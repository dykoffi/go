multipass stop master-ansible &
multipass stop control-plane &
multipass stop data-plane-1 &
multipass stop data-plane-2 &

wait

echo "All instances stopped"