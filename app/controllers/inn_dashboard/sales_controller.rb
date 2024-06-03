class InnDashboard::SalesController < InnDashboard::InnDashboardController
  def new
    @sale = Sale.new
    @inn_rooms = @inn.inn_rooms
  end
end