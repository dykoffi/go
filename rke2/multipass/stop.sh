multipass stop master-ansible &
multipass stop control-plane &
multipass stop data-plane &

wait

echo "All instances stopped"