multipass start master-ansible &
multipass start control-plane &
multipass start data-plane-1 &
multipass start data-plane-2 &

wait

echo "All instances started"