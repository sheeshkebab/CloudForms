vm = $evm.root['vm']
d = DateTime.now

our_server_role = vm.tags(:vm_role).first
$evm.log(:info, "VM #{vm.name} has a server_role tag of: #{our_server_role}")
unless vm.tags(:vm_role).first.nil?
   vm.tags(:vm_role).each do |my_tag_name|
     vm.tag_unassign("vm_role/#{my_tag_name}")
   end
end

dialog_priority = $evm.root['dialog_prioritytext'].pop
#dialog_priority = dialog_priority_tmp.tr('[]', '')
$evm.log("info","Dialog option == #{dialog_priority}")

case dialog_priority
when 'master'
  tag = "vm_role/master"
when 'secondary'
  tag = "vm_role/secondary"
else
  $evm.log("info","Unknown Dialog type")
  tag = "vm_role/notset"
end

$evm.log("info","tag will be = [#{tag}]")
vm.tag_assign(tag)

tmp_d = d.strftime("%d/%m/%Y %H:%M")
$evm.log("info","Current DateTime is #{tmp_d}" )

# Set custom key values
#
key   = "scanned"
value = tmp_d

vm.custom_set(key, value)
vm.scan
exit MIQ_OK
