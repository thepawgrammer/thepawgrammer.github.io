# Ruby + 빌드 도구
FROM ruby:3.2-bookworm

# OS 의존성
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리
WORKDIR /usr/src/app

# 비루트 사용자 준비 (UID 1000 / vscode)
RUN groupadd -g 1000 vscode && useradd -m -u 1000 -g vscode vscode

# Gem 캐시 레이어 최적화: Gemfile* 먼저 복사
COPY Gemfile Gemfile.lock* ./

# Bundler 설치 + ARM64 플랫폼 메모 + 벤더 경로 지정
# (root로 설치해서 경로/권한 문제 방지)
RUN gem install bundler:2.4.19 \
 && bundle lock --add-platform aarch64-linux || true \
 && bundle config set path '/usr/local/bundle' \
 && bundle install --jobs 4 --retry 3

# 나머지 소스 복사
COPY . .

# 작업 경로 소유권을 vscode로
RUN chown -R vscode:vscode /usr/src/app /usr/local/bundle
USER vscode

# Jekyll 서버 포트 + LiveReload 포트
EXPOSE 4000 35729

# 실행
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "-w", "--livereload", "--force_polling"]