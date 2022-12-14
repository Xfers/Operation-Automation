class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
    def index
      @messages = Message.all
      render json: {
        data: @messages.map{ |message| 
        {name: message.name, department: message.department, target_announce_date: message.target_announce_date, id: message.id, approval: message.approval }
      }}
    end 

    def create 
      @message = Message.new(message_params)
      @message.save
      render json:{ message: 'Your announcement request is submitted pending approval'}, status: :ok
    end

    def show
      @message = Message.find(params[:id])
      render json: {
        data: @message
      }
    end

    def update 
      @message = Message.find(params[:id])
      @message.update(message_params)
      
      render json: {
        data: @message.reload
      }

    end

    def accept
      @message = Message.find(params[:id])
      @message.approval = :approved
      @message.save

      SendMessageToSlackJob.set(wait_until: Time.parse(@message.target_announce_date.to_s)).perform_later(@message)
      render json: { message: 'OK' }, status: :ok

    end

    def reject
      @message = Message.find(params[:id])
      @message.approval = :rejected
      @message.save
      render json: { message: 'The announcement request has been rejected, please contact People Team' }, status: :ok

    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy
      render json: { message: 'The announcement has been deleted'}, status: :ok

    end


    
    private

    def message_params
      params.require(:message).permit(:name, :description, :department, :target_announce_date)
    end
end
