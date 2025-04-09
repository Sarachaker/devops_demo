# Stage 1: Builder
FROM python:3.12-alpine as builder  
WORKDIR /build
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.12-alpine
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY src/ .                         
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]
