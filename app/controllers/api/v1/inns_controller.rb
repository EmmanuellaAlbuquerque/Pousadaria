class Api::V1::InnsController < Api::V1::ApiController
  def search
    registration_number = params[:rn]

    inn = Inn.where(registration_number: registration_number).first

    if inn
      return render status: 200, 
             json: inn.as_json(only: 
                                [
                                  :name,
                                  :registration_number,
                                  :description
                                ]
                              )
                              .merge(
                                full_address: inn.full_address,
                                qty_inn_rooms: inn.inn_rooms.count
                              )
    else
      render status: 404, json: { status: "Pousada não encontrada!" }
    end
  end
end