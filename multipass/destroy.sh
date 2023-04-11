multipass delete --purge master-ansible &
multipass delete --purge control-plane &
multipass delete --purge data-plane-1 &
multipass delete --purge data-plane-2 &

wait

echo "All instances destroyed"