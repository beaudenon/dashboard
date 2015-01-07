class SecubatMailerController < ApplicationController
  layout "none"
  def voeux2012
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def pub
    @trackerModel = 0
    @trackerMailing = 0
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def voeux2013
    @trackerModel = 0
    @trackerMailing = 0
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def voeux2014
    @trackerModel = 0
    @trackerMailing = 0
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
end
