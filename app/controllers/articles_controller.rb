# encoding: utf-8
class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.find_or_create_by_uuid(:uuid => SecureRandom.hex(5), :url => params[:article][:url])
    
    unless @article.valid?
      flash[:error] = @article.errors.full_messages.join("<br/>")
      redirect_to new_article_path and return
    end

    require 'rubygems'
    require 'readability'
    require 'open-uri'
    require 'bing_translator'
    require 'nokogiri'
    
    
    source = open(@article.url).read
    translator = BingTranslator.new('hovercraft_with_eels', 'omghovercraftwitheels')
    original = Readability::Document.new(source).content

    parsed = Nokogiri::HTML.parse(original)
    parsed.css('p').each do |div|
      text = div.to_html
      text.encode!( 'UTF-8', invalid: :replace, undef: :replace )
      translation = translator.translate text, :to => 'en'
      @article.blocks << Block.create(:original => text, :translation => translation)
    end

    redirect_to article_path(@article.uuid)
  end

  def show
    @article = Article.find_by_uuid(params[:id])
    @blocks = @article.blocks
    @reading_style = params[:reading_style] || "side_by_side"
    render
  end
end
