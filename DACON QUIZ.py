import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score
import xgboost as xgb
import shap
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import platform

if platform.system() == 'Windows':
    plt.rc('font', family='Malgun Gothic') 

# 1. 데이터 입력
raw_data = [
    ['TRAIN_0000', 2009, 'CT005', '이커머스', 'Series A', 4126.0, '', '', 56.0, 3365.0, 4764.0, 4.71, '', 0.3],
    ['TRAIN_0001', 2023, 'CT006', '핀테크', 'Seed', 4167.0, 'checked', '', 80.0, 4069.0, 279.0, 1.00, '2500-3500', 0.8],
    ['TRAIN_0002', 2018, 'CT007', '기술', 'Series A', 3132.0, 'checked', 'checked', 54.0, 6453.0, 12141.0, 4.00, '3500-4500', 0.5],
    ['TRAIN_0003', 2016, 'CT006', '', 'Seed', 3245.0, 'checked', 'checked', '', 665.0, 10547.0, 2.97, '', 0.7],
    ['TRAIN_0004', 2020, 'CT002', '에듀테크', 'Seed', 1969.0, '', 'checked', 94.0, 829.0, 9810.0, 1.00, '1500-2500', 0.1],
    ['TRAIN_0005', 2012, 'CT008', '기술', 'Series C', 3801.0, '', 'checked', 69.0, 6505.0, 12722.0, 3.00, '2500-3500', 0.6],
    ['TRAIN_0006', 2008, 'CT010', '', 'Series B', 818.0, '', 'checked', '', 3049.0, 666.0, 0.76, '2500-3500', 0.4],
    ['TRAIN_0007', 2020, 'CT002', '게임', 'Series A', 2617.0, '', '', 80.0, 5579.0, 5399.0, 4.00, '3500-4500', 0.7],
    ['TRAIN_0008', 2005, 'CT002', '', 'Series B', '', '', '', 2722.0, 2568.0, 4.94, '', 0.9],
    ['TRAIN_0009', 2009, 'CT008', '', 'Series B', 1757.0, '', '', 285.0, 11758.0, 2.33, '', 0.5]
]

columns = ['ID', '설립연도', '국가', '분야', '투자단계', '직원수', '인수여부1', '인수여부2',
           '고객수', '총투자금', '연매출', '평점', '기업가치', '성공확률']

df = pd.DataFrame(raw_data, columns=columns)

# 2. 결측 보정 및 라벨링 전처리
df['성공확률'] = df['성공확률'].replace('', np.nan).astype(float)
df['성공확률'] = df['성공확률'].fillna(method='ffill')  # 결측값 보정

df['설립연도'] = 2025 - df['설립연도']
df['국가'] = df['국가'].str.extract(r'(\d)$').astype(float)

df['분야'] = df['분야'].fillna('').replace('', '없음')
field_map = {name: idx for idx, name in enumerate(df['분야'].unique())}
df['분야'] = df['분야'].map(field_map)

stage_map = {'Seed': 1, 'Series A': 2, 'Series B': 3, 'Series C': 4}
df['투자단계'] = df['투자단계'].map(stage_map)

df['직원수'] = df['직원수'].replace('', 0).fillna(0).astype(float).astype(int)
df['인수여부1'] = df['인수여부1'].apply(lambda x: 1 if x == 'checked' else 0)
df['인수여부2'] = df['인수여부2'].apply(lambda x: 1 if x == 'checked' else 0)

df['고객수'] = df['고객수'].replace('', 0).fillna(0).astype(float) * 1_000_000
df['총투자금'] = df['총투자금'].replace('', 0).fillna(0).astype(float) * 100_000_000
df['연매출'] = df['연매출'].replace('', 0).fillna(0).astype(float) * 100_000_000

df['기업가치'] = df['기업가치'].astype(str).apply(
    lambda val: ((int(val.split('-')[0]) + int(val.split('-')[1])) / 2) * 1_000_000_000 if '-' in val else 0)

df['평점'] = df['평점'].replace('', 0).fillna(0).astype(float)

# 3. 정규화
numeric_cols = ['설립연도', '국가', '분야', '투자단계', '직원수',
                '인수여부1', '인수여부2', '고객수', '총투자금',
                '연매출', '평점', '기업가치']

scaler = MinMaxScaler()
df[numeric_cols] = scaler.fit_transform(df[numeric_cols])

# 4. XGBoost 모델 학습
X = df.drop(columns=['ID', '성공확률'])
y = df['성공확률']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = xgb.XGBRegressor(
    objective='reg:squarederror',
    n_estimators=20,
    max_depth=3,
    learning_rate=0.1,
    random_state=42,
    verbosity=0
)

model.fit(X_train, y_train)
y_pred = model.predict(X_test)

# 5. 성능 평가
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print("📊 MSE:", mse)
print("📈 R²:", r2)

# 6. SHAP 해석
# SHAP Explainer 생성
explainer = shap.Explainer(model, X_train)

# SHAP 값 계산
shap_values = explainer(X_train)

# 전체 변수 영향력 시각화
shap.summary_plot(shap_values, X_train)

# '국가' 제외하고 SHAP 재계산
X_train_reduced = X_train.drop(columns=['국가'])
explainer_reduced = shap.Explainer(model, X_train_reduced)
shap_values_reduced = explainer_reduced(X_train_reduced)

# 새로운 summary plot
shap.summary_plot(shap_values_reduced, X_train_reduced)
