class MessagesController < ApplicationController
  before_filter :signed_in_user

  def new
    @profile = Profile.find(params[:profile_id])
    @message = Message.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @message = Message.new(message_params)
    @profile = Profile.find(@message.recipient)

    if @message.valid?
      UserMailer.send_message(@message, current_user.id).deliver
      redirect_to profile_path(@profile), notice: "Your message was sent!"
    else
      flash.now.alert = "Oops! Looks like something went wrong."
    end
  end

private

  def message_params
    params.require(:message).permit(:recipient, :body)
  end

end