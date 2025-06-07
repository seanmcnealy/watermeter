#!/bin/bash
record=`/home/smcnealy/go/bin/rtlamr -msgtype=r900 -format=json -filterid=1569874158 -duration=600s -single=true 2>&- | jq -r '.Message.Consumption'`
/usr/local/aws-cli/v2/current/bin/aws timestream-write write-records --database-name watermeter --table-name 1544905322 --records '[{"Dimensions":[{"Name":"MIU","Value":"1569874158","DimensionValueType":"VARCHAR"}],"Time":"'"`date +%s`"'", "TimeUnit":"SECONDS", "MeasureName":"Consumption", "MeasureValueType":"BIGINT", "MeasureValue": "'"$record"'"}]' > /dev/null

