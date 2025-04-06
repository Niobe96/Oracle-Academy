import shap
import xgboost as xgb
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error, r2_score
import matplotlib.pyplot as plt

# 간단한 더미 데이터 생성 (10건 테스트용)
data = {
    '특성1': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    '특성2': [10, 9, 8, 7, 6, 5, 4, 3, 2, 1],
    '특성3': [5, 5, 6, 6, 7, 7, 8, 8, 9, 9],
    '성공확률': [0.1, 0.15, 0.3, 0.25, 0.5, 0.55, 0.7, 0.65, 0.9, 0.85]
}
df = pd.DataFrame(data)

# 정규화
X = df.drop(columns=['성공확률'])
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)
X_scaled = pd.DataFrame(X_scaled, columns=X.columns)

y = df['성공확률']

# 학습/검증 분리
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# XGBoost 학습
model = xgb.XGBRegressor(n_estimators=10, max_depth=3, objective='reg:squarederror', random_state=42)
model.fit(X_train, y_train)

# SHAP 해석
explainer = shap.Explainer(model, X_train)
shap_values = explainer(X_train)

# SHAP summary plot
shap.summary_plot(shap_values, X_train)
