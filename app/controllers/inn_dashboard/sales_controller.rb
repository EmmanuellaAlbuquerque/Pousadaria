class InnDashboard::SalesController < InnDashboard::InnDashboardController
  def new
    @inn_rooms = @inn.inn_rooms
  end

  def create
  end
end