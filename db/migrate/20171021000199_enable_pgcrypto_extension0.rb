class EnablePgcryptoExtension < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'postgis'
  end
end
