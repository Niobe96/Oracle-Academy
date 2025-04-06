from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# 1. 데이터 불러오기
iris = load_iris()
X = iris.data  # 특성 (꽃잎 길이/너비, 꽃받침 길이/너비)
y = iris.target  # 라벨 (품종: 0=setosa, 1=versicolor, 2=virginica)

# 2. 훈련/테스트 데이터 나누기
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# 3. 모델 생성 및 학습
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# 4. 예측 및 정확도 평가
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

print(f"분류 정확도: {accuracy:.2f}")
