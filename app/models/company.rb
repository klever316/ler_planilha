class Company < ActiveRecord::Base
	

  def self.import(file)
  	spreadsheet = Roo::Spreadsheet.open(file)
  	header = spreadsheet.row(1)
  	(2..spreadsheet.last_row).each do |i|
    	row = Hash[[header, spreadsheet.row(i)].transpose]
    	Company.create! row.to_hash
  	end
  end

  def self.open_spreadsheet(file)
  	case File.extname(file.original_filename)
  	when '.csv' then Roo::CSV.new(file.path, nil, :ignore)
  	when ".xls" then Excel.new(file.path, nil, :ignore)
  	when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  	else raise "Unknown file type: #{file.original_filename}"
  	end
  end	

end 


=begin
	
CSV.foreach(file.path, headers: true) do |row|
    Company.create! row.to_hash
end	
=end