module ReservationsHelper 
  def status_style(reservation)
    case reservation.status 
    when "processing"
      return "bg-amber-500 text-black text-center p-3 rounded-xl w-32 hover:brightness-90"
    when "success"
      return "bg-green-500 text-white text-center p-3 rounded-xl w-32 hover:brightness-90"
    when "completed"
      return "bg-white text-gray-600 border-2 border-gray-500 text-center p-3 rounded-xl w-32 hover:brightness-90"
    end
  end
end
