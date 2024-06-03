class InnDashboard::SalesController < InnDashboard::InnDashboardController
  def new
    @sale = @inn.sales.build
    @inn_rooms = @inn.inn_rooms
  end

  def create
    @sale = @inn.sales.build(sale_params)
    @inn_rooms = @inn.inn_rooms

    if @sale.save
      return redirect_to inn_management_path, notice: 'Promoção cadastrada com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  
  def sale_params
    params.require(:sale)
      .permit(
        :name,
        :start_date, 
        :end_date,
        :inn_room_id,
        :discount_percentage
      )
  end
end