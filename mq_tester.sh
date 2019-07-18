#/bin/bash

HOSTIP="158.176.129.211"
NODEPORT="30183"

echo "--------------------------------------------------------------------"
echo "|                        Starting MQ Test                          |"
echo "--------------------------------------------------------------------"


x=1
while [ $x -le 10 ]
do
  sleep 2
  echo "Sending Message @ "$(date "+%H:%M:%S")
  curl -i -s -k https://${HOSTIP}:${NODEPORT}/ibmmq/rest/v1/messaging/qmgr/QM1/queue/DEV.QUEUE.1/message -X POST -u app:password -H 'ibm-mq-rest-csrf-token: blank' -H 'Content-Type: text/plain;charset=utf-8' -d "${x}: Hello World" # | sed -n 's/^\(ibm-mq-md-messageId\)/\1/p'
  echo "--------------------------------------------------------------------"
  sleep 2
  echo "Receiving Message @ "$(date "+%H:%M:%S")
  curl -i -s -k https://${HOSTIP}:${NODEPORT}/ibmmq/rest/v1/messaging/qmgr/QM1/queue/DEV.QUEUE.1/message -X DELETE -u app:password -H 'ibm-mq-rest-csrf-token: blank' # | tail -1
  echo ""
  echo "--------------------------------------------------------------------"
  x=$(( $x + 1 ))
done

echo "--------------------------------------------------------------------"
echo "|                         Ending MQ Test                           |"
echo "--------------------------------------------------------------------"
