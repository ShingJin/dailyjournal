class Entry < ActiveRecord::Base

	acts_as_taggable
	 belongs_to :user



  def self.to_csv
  	require 'csv'

    CSV.generate do |csv|
      csv << column_names
      all.each do |entry|
      	name = Highrise::Person.where("id"=>entry.attributes["contact"]).first.attributes["first_name"] + " " + Highrise::Person.where("id"=>entry.attributes["contact"]).first.attributes["last_name"]
		csv << [entry.attributes["id"].to_s,entry.attributes["entry_text"],name,entry.attributes["tags"][0].to_s,Highrise::Kase.where("id"=>entry.attributes["case"]).first.attributes["name"],entry.attributes["created_at"].to_s,entry.attributes["updated_at"].to_s]
      end
    end
  end

  def self.search(search)
		if search
		   if search.include?("@")
		   	search["@"]=""
		   	search=search.split(",")
		   	Entry.tagged_with(search,:any=>true)
		   else
		    find(:all, :conditions => ['entry_text LIKE ?', "%#{search}%"])
		   end
		else
		    find(:all)
		end
	end


	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
		   Entry.create! row.to_hash
		end
	end


end
