class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum status: { pending: 0, confirmed: 1, cancelled: 2 }, _default: 0

  before_create :end_time_after_start_time, :no_overlap, :room_is_active
  before_save :calculate_price

  def no_overlap
    overlaps = Booking.where(room_id: room_id)
                      .where.not(id: id, status: 2)
                      .where("start_time < ? AND end_time > ?", end_time, start_time)
    errors.add(:base, "Time slot overlaps with existing booking") if overlaps.exists?
  end

  def cancelled
    status == "cancelled"
  end

  def room_is_active
    errors.add(:room, "is not active") unless room&.active?
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "must be after start time") if end_time <= start_time
  end

  def calculate_price
    duration = ((end_time - start_time) / 1.hour).ceil
    self.total_price = room.price_per_hour * duration
  end

  def cancel
    refund = if start_time > 24.hours.from_now
               total_price
             else
               total_price * 0.95
             end
    update(status: :cancelled, refunded_price: refund)
  end
end
