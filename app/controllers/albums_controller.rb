class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :get_artists, only: %i[ new edit ]

  require 'rest-client'
  require 'json'

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
    @submit = 'Novo Album'
  end

  # GET /albums/1/edit
  def edit
    @submit = 'Editar Album'
  end

  # POST /albums or /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def get_artists
      @artists = []
      url = 'https://moat.ai/api/task'
      response = RestClient.get(url, headers={
        'Authorization': 'none',
        'Basic': 'ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ=='
      })
      if response.code == 200
        names = JSON.parse(response.body)
        names.each do |n|
          @artists << n[0]['name']
        end
      else
        @artists = ['connection error, sorry']
      end
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:artist, :album_name, :year)
    end
end
