multipass start master-ansible &
multipass start control-plane &
multipass start data-plane &

wait

echo "All instances started"