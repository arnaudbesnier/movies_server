require 'retriever/batch_retriever'

namespace :db do

  desc "Import movies in db/input folder"
  task :import_movies, [:filename] => :environment do |t, args|
    filename = args[:filename].blank? ? nil : "db/input/#{args[:filename]}.txt"
    batch_retriever = filename.nil? ? BatchRetriever.new : BatchRetriever.new(filename)
    batch_retriever.work
  end

end
