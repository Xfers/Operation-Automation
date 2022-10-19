class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
    def index
      @messages = Message.all
      render json: {
        data: @messages.map{ |message| 
        {name: message.name, department: message.department, target_announce_date: message.target_announce_date, id: message.id }
      }}
    end 

    def create 
      @message = Message.new(message_params)
      @message.save

      client = Slack::Web::Client.new
      client.chat_postMessage(channel: '#project-acw', text: @message.description, as_user: true)
      render json: { message: "OK"}, status: :ok

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
        data: @message
      }

    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy
      render json: { message: "The announcement has been deleted"}, status: :ok

    end


    
    private

    def message_params
      params.require(:message).permit(:name, :description, :department, :target_announce_date)
    end
end
