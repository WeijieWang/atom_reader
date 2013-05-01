class RenamColumnEtageToEtag < ActiveRecord::Migration
  def change
    rename_column :feeds, :etage, :etag
  end
end
