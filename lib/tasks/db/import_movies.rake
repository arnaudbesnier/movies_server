require 'retriever/batch_retriever'

namespace :db do

  desc "Import movies in db/input folder"
  task :import_movies, [:filename] => :environment do |t, args|
    filename = args[:filename].nil? ? nil : "db/input/#{args[:filename]}.txt"
    batch_retriever = BatchRetriever.new filename
    batch_retriever.work
  end

end
