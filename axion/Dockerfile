# =========================
# Stage 1: Builder
# =========================
FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /build

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt* ./

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --upgrade pip \
    && if [ -f requirements.txt ]; then \
         /opt/venv/bin/pip install --no-cache-dir -r requirements.txt; \
       fi

# =========================
# Stage 2: Runtime
# =========================
FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/venv /opt/venv

COPY app.py .

RUN useradd --create-home --uid 10001 axion \
    && chown -R axion:axion /app

USER axion

EXPOSE 8080

CMD ["python", "app.py"]