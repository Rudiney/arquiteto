class CriaIndicadores < ActiveRecord::Migration
  
  def up
    create_table :indicadors do |t|
			t.string	 :nome,           :null => false
			t.string  :tipo
			t.timestamps
		end
	end

   def down
     remove_table :indicadors
   end
  
end
