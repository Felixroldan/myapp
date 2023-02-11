#!/usr/bin/env python
import pika
import sys
credentials = pika.PlainCredentials('zknwcatx', 'vZIkCXCN1drpYmY8zZqP9ZboivZnOF2x')
vhost = 'zknwcatx'
connection = pika.BlockingConnection(pika.ConnectionParameters(host='shrimp.rmq.cloudamqp.com',port=5672, virtual_host= vhost, credentials=credentials))
channel = connection.channel()
channel.exchange_declare(exchange='services', exchange_type='fanout')
result = channel.queue_declare(queue='', exclusive=True)
message = ' '.join(sys.argv[1:]) or "info: Hello World!"
channel.queue_bind(exchange='services', queue=result.method.queue)
channel.basic_publish(exchange='services', routing_key='', body=message)
print(" [x] Sent %r" % message)
connection.close()