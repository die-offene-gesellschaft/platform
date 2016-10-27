class EventProposalsController < ApplicationController
  before_action :authenticate_admin!, except: [:create]
  before_action :set_event_proposal, only: [:show, :destroy]

  # GET /event_proposals
  # GET /event_proposals.json
  def index
    @event_proposals = EventProposal.all
  end

  # GET /event_proposals/1
  # GET /event_proposals/1.json
  def show
  end

  # POST /event_proposals.json
  def create
    @event_proposal = EventProposal.new(event_proposal_params)
    if @event_proposal.save
      render json: { status: 'event proposal saved' },
             status: :ok
    else
      render json: @event_proposal.errors,
             status: :unprocessable_entity
    end
  end

  # DELETE /event_proposals/1
  def destroy
    @event_proposal.destroy
    redirect_to event_proposals_url, notice: 'Event proposal was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_proposal
    @event_proposal = EventProposal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_proposal_params
    params.require(:event_proposal).permit(
      :contact_person_forename,
      :contact_person_mail,
      :contact_person_phone,
      :contact_person_surname,
      :date,
      :logo,
      :organizer,
      :participants,
      :picture,
      :subject,
      :symbol_for_open_society,
      :terms_of_use,
      :title,
      :venue
    )
  end
end
