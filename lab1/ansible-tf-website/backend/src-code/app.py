from flask import Flask, request, jsonify
from opentelemetry import metrics
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from prometheus_client import start_http_server

resource = Resource(attributes={
    SERVICE_NAME: "backend-app"
})
start_http_server(port=9464, addr="0.0.0.0")
reader = PrometheusMetricReader()
provider = MeterProvider(resource=resource, metric_readers=[reader])
metrics.set_meter_provider(provider)

app = Flask(__name__)

@app.route('/_hc', methods=['GET'])
def healthcheck():
    return jsonify({"status": "ok"})

@app.route('/api/greet', methods=['POST'])
def greet_user():
    data = request.get_json()
    name = data.get("name", "Anon")
    return jsonify({"greeting": f"Hello from the backend service, {name}!"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
