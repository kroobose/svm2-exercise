# UCI Exercise
## dataset
- Five datasets in <a href="https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/200223/hayuci13a.zip" rel="nofollow">hayuci13a.zip</a> will be used. Each row is in the format of
<pre> Class, Feature1, Feature2,... , Feature n. </pre>
(邦訳) <a href="https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/200223/hayuci13a.zip" rel="nofollow">hayuci13a.zip</a>
に含まれる５個のデータセット(winequality-white と car は 省略可)を以下で用いていく．各行が
<pre> Class, Feature1, Feature2,... , Feature n</pre>
の形式になっている．

## Code
- srcに必要な関数は入っているので確認すること．

## To do
1. For each dataset, and create a binary classification problem as follows. Assign to the positive class the class with the greatest number of examples, and assign to the netative class the rest of all the examples.
(邦訳)
それぞれのデータセットに対して，次のように２クラス問題を作れ．最多例題を持つクラスを陽性とし，それ以外のクラスを陰性とする．
1. For each of five datasets, divide examples in each class
to two groups with ratio 70%:30%. Importantly, for each class, the one group has 70% of examples and the other group has the rest of examples.
(邦訳)
それぞれのデータセット，それぞれのクラスに対して，例題を 7:3 の比率で２グループに分けよ．前者を訓練用，後者を評価用に使う．
2. Benchmark the pattern recognition performance on the testing subset using the linear SVM trained with the training subset, for each dataset. The regularization parameter $\lambda$ is set to $1/n$ where $n$ is the number of training examples.
(邦訳)
評価用データセットで線形 SVM のパターン認識性能を評価しろ．線形 SVM は訓練用データセットで訓練すること．正則化パラメータは λ=1/n と設定すること．ただし，n は訓練用例題の個数とする．
3. Compare the above result with
the dataset preprocessed by two types of normalization.
    - L1 normalization: L1-norm of each feature vector is one;
    - L2 normalization: L2-norm of each feature vector is one.
- (邦訳)
特徴ベクトルに次の正規化を施した場合と
それぞれ比較せよ．
    - L1 正規化：各例題の L1ノルムを1にする．
    - L2 正規化：各例題の L2ノルムを1にする．
4. Put each of five datasets back to multi-category classification problem.
Train linear SVMs in the one-vs-rest manner
with $\lambda=1/n$.
Benchmark the accuracies of three normalization methods:
no normalization, L1 normalization, and L2 normalization.
(邦訳)
5つのデータセットそれぞれに対して，多クラス問題に戻し，one-vs-rest で学習し，正規化なし，L1正規化，L2正規化それぞれの正解率を算出せよ．正則化パラメータは λ=1/n とせよ．
5. Estimate the value of $\lambda$ by five-fold cross validation
with candidate values $\lambda = 0.1/n, 1/n, 10/n$, and
benchmark the accuracies of the three normalization methods.
(邦訳)
正則化パラメータ λ=1,0.1,0.01 の中から，5-fold cross-validation を使って λ の値を推定し，5つのデータセットそれぞれに対する3つの方法の正解率を算出せよ．
6. Repeat Step 8 ten times to compute ten accuracies for each normalization method. Find the best method. Use the one sample t-test to examine the statistical significance of the difference in accuracy between the best methd and other methods.
(邦訳)
ステップ 8 を１０回繰り返すことで，３つの方法に対して，１０個の正解率を算出し，one sample t-testでP値の表を算出せよ．また，もっともよい方法はどれか？もっともよい方法はそれ以外の方法と統計的有意に差があるか確かめよ．
   - A note on one sample t-test: [onesmpltea1-kato.pdf](https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/200210/onesmpltea1-kato.2002102222.pdf)



