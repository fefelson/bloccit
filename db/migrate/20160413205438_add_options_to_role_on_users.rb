class AddOptionsToRoleOnUsers < ActiveRecord::Migration
  #This migration sets a default value for role on the database level
  #Learn more http://edgeguides.rubyonrails.org/active_record_migrations.html#changing-columns
  # http://stackoverflow.com/a/14229940/2364401
  # Since changes are not reversible we need to use the up/down style
  # http://edgeguides.rubyonrails.org/active_record_migrations.html#using-the-up-down-methods
  def up
    change_column_null :users, :role, false
    change_column_default :users, :role, 0
  end
  
  def down
    change_column_null :users, :role, true
    change_column_default :users, :role, nil
  end
end
