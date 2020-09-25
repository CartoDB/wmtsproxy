import os
import logging

from wmtsproxy_restapi.app import create_app

app = create_app()

logging_handler = logging.StreamHandler()
logging_handler.setLevel(logging.DEBUG)
app.logger.addHandler(logging_handler)

port = os.environ.get('PROXY_PORT')
if port is None:
  port = 9091
else:
  port = int(port)

if __name__ == '__main__':
    app.run(host='0.0.0.0', threaded=True, port=port)
