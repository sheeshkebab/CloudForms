cat = $evm.object['category_name']
$evm.log("info", "The current category we are using is #{cat}")


if $evm.execute('category_exists?', cat)
  $evm.log("info", "Category vm_role exists")
else
  $evm.log("info", "Category vm_role doesn't exist, creating category")
  $evm.execute('category_create', :name => cat, :single_value => false, :description => "VMRole")
end


unless $evm.execute('tag_exists?', cat, 'master')
  $evm.execute('tag_create', cat, :name => "master", :description => "PrimaryRole")
  $evm.log("info", "Adding master tag into Category #{cat}")
end

unless $evm.execute('tag_exists?', cat, 'secondary')
  $evm.execute('tag_create', cat, :name => "secondary", :description => "SecondaryRole")
  $evm.log("info", "Adding secondary tag into Category #{cat}")
end
