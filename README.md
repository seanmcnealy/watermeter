# watermeter

Your utility's water meter may be broadcasting your current usage all the time. You can capture that information and implement your own reporting and alerting.

![Example graphs of water meter readings](watermeter_screenshot.png "Example graphs of water meter readings")

Uses [RTL AMR](https://github.com/bemasher/rtlamr) to collect the metrics and publish to AWS Timestream database. Any cloud database will do, since it's easy to use a free cloud reporting instance like Grafana.

Important considerations for the script parameters

The electronics in my meter take a reading every 15 minutes and broadcasts that reading every ~1 minute. I think it's just a fire-and-forget broadcast without any carrier detection. It's just a small packet.
I don't get every message so I set RTL AMR to listen for up to 10 minutes. Cron runs the script every 15 minutes.

I use the "single" reading every run because capturing the next message yields the same reading amount. Waiting for a while after a reading means the next reading should be different.

![Diagram of cron calling RTL SDR to insert to Amazon Timestream, with Grafana reading](block_diagram.svg "Diagram of cron calling RTL SDR to insert to Amazon Timestream, with Grafana reading")

I tried running this on a RaspberryPi I have from other projects. But that board isn't supplying enough power to the RTL SDR over USB to be stable. Current platform is an old laptop.

