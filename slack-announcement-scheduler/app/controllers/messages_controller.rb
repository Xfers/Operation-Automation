class MessagesController < ApplicationController
    def index
      @messages = Message.all
    end 
    
    def new
      @message = Message.new
    end

    def create 
      @message = Message.new(message_params)
      @message.save

      client = Slack::Web::Client.new
      client.chat_postMessage(channel: '#project-acw', text: @message.description, as_user: true)
      redirect_to action: :index

    end

    def show
      @message = Message.find(params[:id])
    end

    def edit
      @message = Message.find(params[:id])
    end

    def update 
      @message = Message.find(params[:id])
      @message.update(message_params)

      redirect_to action: :show, id: @message
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy

      redirect_to action: :index
    end


    
    private

    def message_params
      params.require(:message).permit(:name, :description)
    end
end
