# SHProject

## 개요

- 본 앱은 iphone Xr에서 최적화 되어있습니다.
- Tumblr의 API를 받아와서 Image만 볼 수 있도록 구성했습니다.

## Requirement

- Tumblr API로 부터 Auth 1.0을 이용해서 토큰 정보를 받아온 뒤 user, dashboard 정보를 받아옴.
- dashboard 정보 중 이미지 정보만 보여줌
- 리스트 화면과 디테일 화면에서 pagination 및 동기화 구현.
- 리스트 화면 <-> 디테일 화면 애니메이션 구현.
- 리스트 화면의 경우 이미지, tag 또는 summary를 보여줌.
- 디테일 화면은 이미지와 이미지 배포자 정보, 이미지 trail(원작자)의 정보를 노출.
