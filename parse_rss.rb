#!/usr/local/bin/ruby
# coding: utf-8

require 'open-uri'
require 'rss'

# open url list
fh = open("./url.list")

# parse rss
fh.each do |url|
    puts "URL: " + url
    begin
        rss = open(url){|file| RSS::Parser.parse(file.read)}
    rescue => ex
        puts ex.message
        next
    end
    puts "Site: " + rss.channel.title

    rss.items.each do |item|
        puts "Title: " + item.title
        # get hatebu count
        begin
            count = open("http://api.b.st-hatena.com/entry.count?url=" + item.link).read
        rescue => ex
            puts ex.message
            next
        end
        puts "Hatebu Count: " + count
    end
end
