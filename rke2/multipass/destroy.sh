multipass delete --purge master-ansible &
multipass delete --purge control-plane &
multipass delete --purge data-plane &

wait

echo "All instances destroyed"