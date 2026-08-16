# 피씨와 노트북이 E의 작업공간 공유

## 핵심 개념

이 프로젝트의 목표는 PC와 노트북을 서로 동기화하는 것이 아니라, 하나의 `E:\dev\codex` 작업공간을 PC와 노트북이 번갈아 사용하는 것입니다.

```text
동기화 방식:
PC의 작업 폴더 <-> 노트북의 작업 폴더
복사본 2개를 계속 맞춰야 하므로 충돌과 최신본 문제가 생길 수 있음

공유 작업공간 방식:
PC -> E:\dev\codex
노트북 -> 같은 E:\dev\codex
원본 작업공간은 하나이고, 기기만 바꿔서 접근함
```

## 권장 구성

```text
PC:
Codex/ChatGPT 앱은 C 드라이브 기본 위치에 설치
작업은 E:\dev\codex 에서 진행

노트북:
Codex/ChatGPT 앱은 C 드라이브 기본 위치에 설치
같은 E 드라이브를 연결한 뒤 E:\dev\codex 에서 이어서 작업

공유 작업공간:
E:\dev\codex
```

## 권장 폴더 구조

```text
E:\dev\codex
  project-a
  project-b
  project-c
  _docs
  _notes
  _prompts
  _archive
```

- `project-a`, `project-b`, `project-c`: 실제 개발 프로젝트
- `_docs`: 공통 문서와 사용 설명
- `_notes`: 작업 메모
- `_prompts`: 자주 쓰는 Codex 요청문
- `_archive`: 완료했거나 잠시 보관할 프로젝트

## 사용 순서

1. PC에 E 드라이브를 연결합니다.
2. Codex/ChatGPT 앱을 실행합니다.
3. `E:\dev\codex` 안의 프로젝트를 엽니다.
4. 작업을 마친 뒤 실행 중인 서버, 터미널, 에디터, Codex 작업을 정리합니다.
5. E 드라이브를 안전하게 제거합니다.
6. 노트북에 같은 E 드라이브를 연결합니다.
7. 노트북의 Codex/ChatGPT 앱에서 같은 `E:\dev\codex` 프로젝트를 엽니다.
8. 이어서 작업합니다.

## 중요한 원칙

- PC와 노트북에서 동시에 같은 E 작업공간을 열어 작업하지 않습니다.
- E 드라이브를 분리하기 전에는 실행 중인 개발 서버와 터미널을 종료합니다.
- 외장 SSD라면 반드시 안전 제거 후 분리합니다.
- 프로젝트 원본은 `E:\dev\codex`에 둡니다.
- 앱, 런타임, 캐시, 계정 로그인 정보는 각 컴퓨터의 C 드라이브에 따로 둡니다.

## 기기별로 따로 설치할 것

PC와 노트북에는 각각 아래 도구를 설치해 둡니다.

```text
Codex/ChatGPT 데스크톱 앱
Git
VS Code
Node.js
Python
npm 또는 pnpm
필요한 개발 도구
```

## 주의할 폴더와 파일

아래 항목은 기기 차이 때문에 문제가 생기거나 보안상 주의가 필요합니다.

```text
node_modules
.venv
dist
build
.next
.cache
.env
*.key
*.pem
로컬 데이터베이스 파일
```

가능하면 `node_modules`, `.venv`, 빌드 캐시는 프로젝트마다 다시 만들 수 있게 관리합니다. `.env`와 키 파일은 외부에 공유하지 않고, 필요한 경우 E 드라이브 안에서만 조심해서 보관합니다.

## 추천 .gitignore 기본값

Git을 쓰는 프로젝트라면 아래 항목을 `.gitignore`에 포함하는 것을 권장합니다.

```gitignore
node_modules/
.venv/
dist/
build/
.next/
.cache/
.env
*.key
*.pem
```

## Codex 사용 메모

Codex에게 작업을 요청할 때는 현재 작업 위치를 분명히 알려주면 좋습니다.

```text
현재 프로젝트는 E:\dev\codex\project-a 입니다.
PC와 노트북이 같은 E 드라이브 작업공간을 번갈아 사용합니다.
로컬 C 드라이브가 아니라 E 드라이브의 프로젝트 파일만 수정해 주세요.
```

## 가장 안정적인 운영 방식

```text
앱 설치:
C 드라이브 기본 위치

작업공간:
E:\dev\codex

작업 방식:
PC에서 작업 -> 종료 -> E 드라이브 안전 제거 -> 노트북에 연결 -> 이어서 작업

백업:
중요 프로젝트는 GitHub, 별도 외장 저장소, 또는 압축 백업으로 주기적으로 보관
```

## 백업 원칙

공유 작업공간 방식은 편리하지만, E 드라이브가 유일한 원본이 되면 드라이브 고장이나 실수에 취약합니다.

중요한 프로젝트는 다음 중 하나 이상으로 백업합니다.

```text
GitHub 비공개 저장소
다른 외장 SSD
압축 백업
NAS
OneDrive 또는 Google Drive 백업 폴더
```

## 결론

PC와 노트북을 동기화하는 것이 아니라 하나의 E 드라이브 작업공간을 공유하는 방식은 충분히 가능합니다. 핵심은 Codex 앱은 각 기기의 C 드라이브에 설치하고, 실제 프로젝트 원본은 `E:\dev\codex`에 두며, 두 기기에서 동시에 같은 작업공간을 열지 않는 것입니다.
