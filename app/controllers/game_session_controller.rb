class GameSessionController < ApplicationController
  skip_before_action :verify_authenticity_token
  def start
    @session = GameSession.new
  end

  def store
    @session = GameSession.new(session_params)
    @session.user_id = current_user.id
    @session.game_id = params[:id]

    respond_to do |sesh|
      @session.save!

      sesh.html { redirect_to sessions_index_path, notice: 'Session Stored.' }
      sesh.json { render :show, status: :created, location: @session }
    end
  end

  def update_score

    game = GameSession.new

    user_id = 1 #current_user.id -> need to be fixed


    game.user_id = user_id
    game.game_id = params[:id]
    game.score = params[:score]
    game.save!

    scores = GameSession.where(user_id: user_id, game_id: params[:id]).map(&:score).compact.inject(:+)
    render json: { is_success: true, score: scores }
  end

  def get_score
    user_id = 1 #current_user.id -> need to be fixed
    scores = GameSession.where(user_id: user_id, game_id: params[:id]).map(&:score).compact.inject(:+)
    render json: { is_success: true, score: scores }

  end

  def statistics
    render stats_path
  end

  def index
    @sessions = GameSession.where(user_id: current_user.id)


    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Game Stats")
      f.xAxis(categories: ["Sounds Game", "Speed Game", "Identification Game"])
      f.series(name: "Total Time Elapsed", yAxis: 0, data: [time_elapsed(1), time_elapsed(2), time_elapsed(3)])
      f.series(name: "Total Score in Game", yAxis: 1, data: [total_score(1), total_score(2), total_score(3)])

      f.yAxis [
        {title: {text: "Total Time Elapsed", margin: 70} },
        {title: {text: "Total Score in Game"}, opposite: true},
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
      end

      @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
      end
  end


private

  def session_params
    params.require(:game_session).permit(:score, :user_id, :game_id)
  end

  def time_elapsed(game_id)
    @sessions.where(game_id: game_id).all.collect.sum{|s| s.created_at - s.updated_at} #This needs to be touched up
  end

  def total_score(game_id)
    @sessions.where(game_id: game_id).sum(:score) #This also needss a retouch
  end

end
