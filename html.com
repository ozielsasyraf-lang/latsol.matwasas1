<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tes Matematika Kelas XI — Fungsi &amp; Barisan/Deret</title>
<style>
  :root{
    --bg:#f4f6fb; --card:#ffffff; --ink:#1e293b; --muted:#64748b;
    --accent:#2563eb; --accent-soft:#dbeafe; --line:#e2e8f0;
    --ok:#15803d; --ok-soft:#dcfce7; --bad:#b91c1c; --bad-soft:#fee2e2;
    --warn:#b45309; --warn-soft:#fef3c7;
  }
  *{box-sizing:border-box}
  html,body{margin:0;padding:0}
  body{
    background:var(--bg); color:var(--ink); line-height:1.68;
    font-family:"Segoe UI",system-ui,-apple-system,"Helvetica Neue",Arial,sans-serif;
    font-size:16px; -webkit-text-size-adjust:100%;
  }
  .wrap{max-width:900px;margin:0 auto;padding:0 16px}
  sub,sup{font-size:.72em;line-height:0}

  /* ===== HEADER ===== */
  header.topbar{
    background:linear-gradient(135deg,#1e3a8a 0%,#2563eb 100%);
    color:#fff; padding:26px 0 22px; box-shadow:0 4px 18px rgba(30,58,138,.22);
  }
  header.topbar h1{margin:0;font-size:1.42rem;letter-spacing:.2px}
  header.topbar .sub{margin:4px 0 18px;font-size:.9rem;opacity:.88}
  .scoregrid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}
  .scorecard{
    background:rgba(255,255,255,.14); border:1px solid rgba(255,255,255,.22);
    border-radius:10px; padding:9px 11px; display:flex; flex-direction:column;
  }
  .scorecard .label{font-size:.7rem;text-transform:uppercase;letter-spacing:.6px;opacity:.85}
  .scorecard .val{font-size:1.02rem;font-weight:600;margin-top:1px}
  .scorecard .val b{font-size:1.28rem}
  .scorecard.total{background:rgba(255,255,255,.95);color:#1e3a8a;border-color:#fff}
  .scorecard.total .label{opacity:.75}

  /* ===== TABS ===== */
  nav.tabs{display:flex;gap:8px;margin:20px auto 0;flex-wrap:wrap}
  nav.tabs button{
    flex:1 1 auto; min-width:150px; cursor:pointer;
    background:#fff; border:1px solid var(--line); border-radius:10px;
    padding:11px 14px; font-size:.92rem; font-weight:600; color:var(--muted);
    font-family:inherit; transition:.16s; text-align:center;
  }
  nav.tabs button span{display:block;font-size:.72rem;font-weight:400;opacity:.75}
  nav.tabs button:hover{border-color:#bfdbfe;color:var(--accent)}
  nav.tabs button.active{background:var(--accent);border-color:var(--accent);color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.3)}
  nav.tabs button.active span{opacity:.9}

  /* ===== PANELS ===== */
  main.wrap{padding-top:20px;padding-bottom:60px}
  .panel{display:none;animation:fade .25s ease}
  .panel.active{display:block}
  @keyframes fade{from{opacity:0;transform:translateY(6px)}to{opacity:1;transform:none}}
  .section-note{
    background:var(--accent-soft); border-left:4px solid var(--accent);
    border-radius:8px; padding:11px 14px; font-size:.87rem; color:#1e40af; margin-bottom:16px;
  }

  /* ===== CARDS ===== */
  .card{
    background:var(--card); border:1px solid var(--line); border-radius:12px;
    padding:16px 18px 14px; margin-bottom:16px; box-shadow:0 1px 3px rgba(15,23,42,.05);
  }
  .qhead{display:flex;gap:11px;align-items:flex-start;margin-bottom:13px}
  .num{
    flex:0 0 auto; width:27px;height:27px;border-radius:8px;background:var(--accent-soft);
    color:var(--accent); font-weight:700; font-size:.83rem; display:flex;
    align-items:center;justify-content:center; margin-top:2px;
  }
  .qtext{font-size:.96rem}
  .qtext .situasi{
    display:block; background:#f8fafc; border:1px dashed #cbd5e1;
    border-radius:8px; padding:10px 12px; margin-bottom:9px; font-size:.92rem;
  }
  .qtext ul{margin:6px 0 6px 18px;padding:0}
  .qtext li{margin:3px 0}

  /* ===== PG OPTIONS ===== */
  .opts{display:flex;flex-direction:column;gap:8px}
  .opt{
    display:flex;gap:10px;align-items:flex-start;width:100%;text-align:left;cursor:pointer;
    background:#fff;border:1.5px solid var(--line);border-radius:9px;
    padding:9px 12px;font-family:inherit;font-size:.93rem;color:var(--ink);
    transition:.14s;
  }
  .opt:hover{border-color:#93c5fd;background:#f8fbff}
  .opt .tag{
    flex:0 0 auto;width:23px;height:23px;border-radius:50%;background:#f1f5f9;color:var(--muted);
    font-weight:700;font-size:.78rem;display:flex;align-items:center;justify-content:center;
  }
  .opt.sel{border-color:var(--accent);background:#eff6ff}
  .opt.sel .tag{background:var(--accent);color:#fff}
  .opt.correct{border-color:var(--ok);background:var(--ok-soft)}
  .opt.correct .tag{background:var(--ok);color:#fff}
  .opt.wrong{border-color:var(--bad);background:var(--bad-soft)}
  .opt.wrong .tag{background:var(--bad);color:#fff}
  .opt.locked{cursor:default}
  .opt.locked:hover{border-color:inherit;background:inherit}
  .opt.correct.locked:hover{background:var(--ok-soft);border-color:var(--ok)}
  .opt.wrong.locked:hover{background:var(--bad-soft);border-color:var(--bad)}

  /* ===== BUTTONS ===== */
  .actions{margin-top:12px;display:flex;gap:9px;flex-wrap:wrap}
  button.btn{
    font-family:inherit;font-size:.85rem;font-weight:600;cursor:pointer;
    border-radius:8px;padding:8px 15px;border:1px solid transparent;transition:.15s;
  }
  button.btn-check{background:var(--accent);color:#fff}
  button.btn-check:hover:not(:disabled){background:#1d4ed8}
  button.btn-check:disabled{background:#e2e8f0;color:#94a3b8;cursor:not-allowed}
  button.btn-key{background:#0f172a;color:#fff}
  button.btn-key:hover{background:#1e293b}

  /* ===== FEEDBACK ===== */
  .feedback{margin-top:13px;border-radius:9px;padding:11px 14px;font-size:.89rem;border:1px solid}
  .feedback.hidden{display:none}
  .feedback.ok{background:var(--ok-soft);border-color:#86efac}
  .feedback.bad{background:var(--bad-soft);border-color:#fca5a5}
  .feedback .fbhead{font-weight:700;margin-bottom:5px;font-size:.9rem}
  .feedback.ok .fbhead{color:var(--ok)}
  .feedback.bad .fbhead{color:var(--bad)}
  .feedback .fbtext{color:#334155}

  /* ===== B/S ===== */
  .bsbtns{display:flex;gap:9px}
  .bsbtns button{
    flex:1;font-family:inherit;font-size:.9rem;font-weight:600;cursor:pointer;
    padding:10px;border-radius:9px;border:1.5px solid var(--line);background:#fff;color:var(--ink);
    transition:.14s;
  }
  .bsbtns button:hover:not(:disabled){border-color:#93c5fd;background:#f8fbff}
  .bsbtns button:disabled{cursor:default}
  .bsbtns button.pick-ok{background:var(--ok);border-color:var(--ok);color:#fff}
  .bsbtns button.pick-bad{background:var(--bad);border-color:var(--bad);color:#fff}
  .bsbtns button.reveal-ok{background:var(--ok-soft);border-color:var(--ok);color:var(--ok)}
  .bsbtns button.dim{opacity:.5}

  /* ===== ESAI ===== */
  textarea{
    width:100%;min-height:110px;resize:vertical;font-family:inherit;font-size:.92rem;
    padding:11px 13px;border:1.5px solid var(--line);border-radius:9px;color:var(--ink);
    background:#fdfdff;line-height:1.6;
  }
  textarea:focus{outline:none;border-color:var(--accent);background:#fff;box-shadow:0 0 0 3px rgba(37,99,235,.12)}
  .keybox{margin-top:14px;border:1px solid #cbd5e1;border-radius:10px;background:#f8fafc;padding:14px 16px;font-size:.89rem}
  .keybox.hidden{display:none}
  .keybox h4{margin:0 0 7px;font-size:.86rem;text-transform:uppercase;letter-spacing:.5px;color:var(--accent)}
  .keybox h4:not(:first-child){margin-top:16px}
  .keybox .kunci{background:#fff;border:1px solid var(--line);border-radius:8px;padding:11px 13px;line-height:1.75}
  .rubrik{margin:0;padding-left:20px}
  .rubrik li{margin:4px 0}
  .selfscore{margin-top:14px;display:flex;align-items:center;gap:8px;flex-wrap:wrap;
    background:var(--warn-soft);border:1px solid #fcd34d;border-radius:9px;padding:10px 13px}
  .selfscore span{font-size:.85rem;font-weight:600;color:var(--warn)}
  .selfscore button{
    width:34px;height:34px;border-radius:50%;border:1.5px solid #f59e0b;background:#fff;
    color:#b45309;font-weight:700;font-family:inherit;cursor:pointer;font-size:.88rem;transition:.14s;
  }
  .selfscore button:hover{background:#fde68a}
  .selfscore button.on{background:#f59e0b;color:#fff;border-color:#b45309}

  /* ===== RESPONSIVE ===== */
  @media (max-width:640px){
    header.topbar h1{font-size:1.15rem}
    .scoregrid{grid-template-columns:repeat(2,1fr);gap:8px}
    nav.tabs button{flex:1 1 100%}
    .card{padding:14px 14px 12px}
    .qtext{font-size:.93rem}
    .opt{font-size:.89rem}
    .bsbtns{flex-direction:column}
  }
</style>
</head>
<body>

<header class="topbar">
  <div class="wrap">
    <h1>Tes Matematika Kelas XI</h1>
    <p class="sub">Fungsi · Komposisi &amp; Invers · Barisan &amp; Deret · Aplikasi Keuangan</p>
    <div class="scoregrid">
      <div class="scorecard"><span class="label">Pilihan Ganda</span><span class="val"><b id="s-pg">0</b> / 15</span></div>
      <div class="scorecard"><span class="label">Benar / Salah</span><span class="val"><b id="s-bs">0</b> / 10</span></div>
      <div class="scorecard"><span class="label">Esai HOTS</span><span class="val"><b id="s-es">0</b> / 20</span></div>
      <div class="scorecard total"><span class="label">Skor Total</span><span class="val"><b id="s-tot">0</b> / 45</span></div>
    </div>
  </div>
</header>

<nav class="tabs wrap">
  <button class="tab active" data-target="pg">A. Pilihan Ganda<span>15 soal · 15 poin</span></button>
  <button class="tab" data-target="bs">B. Benar / Salah<span>10 soal · 10 poin</span></button>
  <button class="tab" data-target="esai">C. Esai HOTS+++<span>5 soal · 20 poin</span></button>
</nav>

<main class="wrap">
  <section id="pg" class="panel active"></section>
  <section id="bs" class="panel"></section>
  <section id="esai" class="panel"></section>
</main>

<script>
/* =========================================================
   DATA SOAL
   ========================================================= */

const PG = [
{
  q: `Diketahui fungsi <b>f: ℝ → ℝ</b> dengan <b>f(x) = 2x − 3</b> dan domain D<sub>f</sub> = {x | −2 ≤ x ≤ 5, x ∈ ℝ}. Domain dari fungsi invers f<sup>−1</sup> adalah ...`,
  opts: [
    '{x | −7 ≤ x ≤ 7, x ∈ ℝ}',
    '{x | −2 ≤ x ≤ 5, x ∈ ℝ}',
    '{x | x ∈ ℝ}',
    '{x | x ≥ −7, x ∈ ℝ}',
    '{x | −5 ≤ x ≤ 2, x ∈ ℝ}'
  ],
  ans: 0,
  expl: 'Kunci: D<sub>f⁻¹</sub> = R<sub>f</sub>. Karena f linear naik pada domainnya, R<sub>f</sub> = [f(−2), f(5)] = [−7, 7]. Pilihan B adalah jebakan: itu domain f, bukan domain f<sup>−1</sup>.'
},
{
  q: `Diketahui <b>f(x) = x² − 3x</b> dan <b>g(x) = 2x + 1</b>. Nilai dari <b>(f∘g)(2) − (g∘f)(2)</b> adalah ...`,
  opts: ['−13','3','7','13','17'],
  ans: 3,
  expl: 'Kunci: (f∘g)(2) = f(g(2)) = f(5) = 25 − 15 = 10. (g∘f)(2) = g(f(2)) = g(−2) = −4 + 1 = −3. Selisihnya 10 − (−3) = <b>13</b>. Kesalahan umum: tertukar urutan komposisi.'
},
{
  q: `Diketahui <b>f(x) = 2x − 1</b>, <b>g(x) = x²</b>, dan <b>h(x) = 3 − x</b>. Nilai <b>(f∘g∘h)(−1)</b> adalah ...`,
  opts: ['15','23','31','47','49'],
  ans: 2,
  expl: 'Kunci: kerjakan dari dalam. h(−1) = 3 − (−1) = 4 → g(4) = 16 → f(16) = 2(16) − 1 = <b>31</b>. Pengecoh 47 muncul bila urutan komposisi dibalik.'
},
{
  q: `Diketahui <b>(f∘g)(x) = 4x² + 12x + 5</b> dan <b>g(x) = 2x + 3</b>. Rumus fungsi f(x) adalah ...`,
  opts: ['x² + 4','x² − 4','x² − 6','x² + 6','2x² − 4'],
  ans: 1,
  expl: 'Kunci: misalkan u = 2x + 3, maka x = (u − 3)/2. f(u) = 4((u−3)/2)² + 12((u−3)/2) + 5 = (u−3)² + 6(u−3) + 5 = u² − 4. Jadi <b>f(x) = x² − 4</b>.'
},
{
  q: `Diketahui <b>f(x) = 3x − 5</b> dan <b>g(x) = x + 2</b>. Rumus <b>(g∘f)<sup>−1</sup>(x)</b> adalah ...`,
  opts: ['(x − 3)/3','(x + 3)/3','(x + 7)/3','3x + 3','3x − 3'],
  ans: 1,
  expl: 'Kunci: (g∘f)(x) = 3x − 3, inversnya y = 3x − 3 → x = (y + 3)/3. Cek dengan sifat (g∘f)<sup>−1</sup> = f<sup>−1</sup>∘g<sup>−1</sup> = ((x − 2) + 5)/3 = (x + 3)/3. Sama.'
},
{
  q: `Di antara fungsi berikut, yang merupakan fungsi <b>surjektif (onto)</b> dari ℝ ke ℝ adalah ...`,
  opts: ['f(x) = x²','f(x) = |x|','f(x) = 2x − 7','f(x) = x² + 1','f(x) = 1/x'],
  ans: 2,
  expl: 'Kunci: hanya fungsi linear dengan gradien ≠ 0 yang memetakan ℝ <i>onto</i> ℝ. Fungsi kuadrat dan nilai mutlak selalu bernilai ≥ 0 sehingga tidak menjangkau bilangan negatif; 1/x tidak terdefinisi di 0.'
},
{
  q: `Fungsi <b>f(x) = x² − 4x + 7</b> memiliki domain {x | 0 ≤ x ≤ 5, x ∈ ℝ}. Range dari f adalah ...`,
  opts: ['[3, 12]','[3, 7]','[7, 12]','[0, 12]','[3, 25]'],
  ans: 0,
  expl: 'Kunci: titik puncak di x = 2 dengan f(2) = 3 (nilai minimum). Nilai di ujung interval: f(0) = 7 dan f(5) = 12. Jadi range = <b>[3, 12]</b>.'
},
{
  q: `Di antara bilangan <b>7</b> dan <b>67</b> disisipkan 5 bilangan sehingga terbentuk barisan aritmatika. Beda barisan yang baru adalah ...`,
  opts: ['6','8','10','12','15'],
  ans: 2,
  expl: 'Kunci: banyak suku menjadi 5 + 2 = 7, sehingga b = (67 − 7)/(7 − 1) = 60/6 = <b>10</b>. Pengecoh 12 muncul bila 60 dibagi 5 (lupa bahwa suku bertambah menjadi 7).'
},
{
  q: `Suku ke-5 suatu barisan aritmatika adalah 20 dan suku ke-10 adalah 40. Jumlah 20 suku pertamanya adalah ...`,
  opts: ['780','800','840','860','880'],
  ans: 2,
  expl: 'Kunci: b = (40 − 20)/(10 − 5) = 4; a = 20 − 4·4 = 4. S₂₀ = 20/2 · (2·4 + 19·4) = 10 · 84 = <b>840</b>.'
},
{
  q: `Suku ke-3 dan suku ke-6 suatu barisan geometri berturut-turut adalah 12 dan 96. Suku ke-8 barisan tersebut adalah ...`,
  opts: ['192','288','384','576','768'],
  ans: 2,
  expl: 'Kunci: r³ = 96/12 = 8 → r = 2. a = 12/2² = 3. U₈ = 3 · 2⁷ = <b>384</b>.'
},
{
  q: `Jumlah tak hingga dari deret geometri <b>18 + 12 + 8 + ...</b> adalah ...`,
  opts: ['27','36','45','54','108'],
  ans: 3,
  expl: 'Kunci: r = 12/18 = 2/3 (memenuhi |r| < 1). S∞ = a/(1 − r) = 18/(1/3) = <b>54</b>.'
},
{
  q: `Modal sebesar <b>Rp5.000.000</b> diinvestasikan dengan bunga majemuk 8% per tahun. Nilai investasi setelah 3 tahun adalah ...`,
  opts: ['Rp6.200.000','Rp6.298.560','Rp6.320.000','Rp6.400.000','Rp6.500.000'],
  ans: 1,
  expl: 'Kunci: M₃ = 5.000.000 × (1,08)³ = 5.000.000 × 1,259712 = <b>Rp6.298.560</b>. Pengecoh A adalah hasil bunga tunggal (5.000.000 × 1,24).'
},
{
  q: `Populasi bakteri mula-mula 500 sel dan tumbuh 20% setiap jam. Populasi setelah 4 jam (dibulatkan ke satuan terdekat) adalah ...`,
  opts: ['900 sel','1.000 sel','1.037 sel','1.100 sel','1.200 sel'],
  ans: 2,
  expl: 'Kunci: N₄ = 500 × (1,2)⁴ = 500 × 2,0736 = 1.036,8 ≈ <b>1.037 sel</b>. Pengecoh 1.100 berasal dari pertumbuhan linear (500 + 4 × 150).'
},
{
  q: `Suatu zat radioaktif bermassa 800 gram meluruh sebesar 25% setiap 2 jam. Massa zat setelah 6 jam adalah ...`,
  opts: ['200 gram','300 gram','337,5 gram','400 gram','450 gram'],
  ans: 2,
  expl: 'Kunci: 6 jam = 3 periode peluruhan. M = 800 × (0,75)³ = 800 × 0,421875 = <b>337,5 gram</b>. Pengecoh 400 muncul bila siswa memakai faktor 0,5 (mengira meluruh 50%).'
},
{
  q: `Pinjaman sebesar <b>Rp10.000.000</b> akan dilunasi dengan anuitas tahunan selama 4 tahun pada suku bunga 10% per tahun. Besar anuitasnya adalah ...`,
  opts: ['Rp2.500.000','Rp3.000.000','Rp3.154.708','Rp3.500.000','Rp4.000.000'],
  ans: 2,
  expl: 'Kunci: A = P·i / [1 − (1+i)<sup>−n</sup>] = 10.000.000(0,1) / [1 − (1,1)<sup>−4</sup>] = 1.000.000 / 0,3169865 ≈ <b>Rp3.154.708</b>.'
}
];

/* --------------------------------------------------------- */

const BS = [
{
  q: `Fungsi <b>f: ℝ → ℝ</b> dengan <b>f(x) = x²</b> merupakan fungsi bijektif.`,
  ans: false,
  expl: 'SALAH. f tidak injektif karena f(−1) = f(1) = 1, dan tidak surjektif karena tidak ada x ∈ ℝ dengan f(x) = −1.'
},
{
  q: `Jika <b>f(x) = 2x + 3</b>, maka <b>f<sup>−1</sup>(x) = (x − 3)/2</b>.`,
  ans: true,
  expl: 'BENAR. Dari y = 2x + 3 diperoleh x = (y − 3)/2, sehingga f<sup>−1</sup>(x) = (x − 3)/2.'
},
{
  q: `Untuk sebarang fungsi f dan g, selalu berlaku <b>(f∘g)(x) = (g∘f)(x)</b>.`,
  ans: false,
  expl: 'SALAH. Komposisi fungsi tidak komutatif. Contoh: f(x) = x², g(x) = x + 1 → (f∘g)(x) = (x+1)², sedangkan (g∘f)(x) = x² + 1.'
},
{
  q: `Jika <b>f∘g = I</b> dan <b>g∘f = I</b> dengan I fungsi identitas, maka <b>g = f<sup>−1</sup></b>.`,
  ans: true,
  expl: 'BENAR. Itulah definisi fungsi invers: dua fungsi yang saling membatalkan (komposisinya identitas) adalah invers satu sama lain.'
},
{
  q: `Diketahui <b>f(x) = 3 − 2x</b>. Maka <b>(f∘f)(x) = 4x − 3</b>.`,
  ans: true,
  expl: 'BENAR. f(f(x)) = 3 − 2(3 − 2x) = 3 − 6 + 4x = 4x − 3. Perhatikan bahwa (f∘f) bukan fungsi identitas karena f bukan invers dirinya sendiri.'
},
{
  q: `Barisan <b>3, 6, 12, 24, ...</b> adalah barisan aritmatika dengan beda 3.`,
  ans: false,
  expl: 'SALAH. Selisih antarsuku tidak tetap (3, 6, 12), tetapi rasionya tetap 2. Jadi itu barisan geometri dengan rasio 2.'
},
{
  q: `Jumlah n suku pertama barisan aritmatika dirumuskan <b>S<sub>n</sub> = (n/2)(2a + (n − 1)b)</b>.`,
  ans: true,
  expl: 'BENAR. Rumus ini setara dengan S<sub>n</sub> = (n/2)(a + U<sub>n</sub>) karena U<sub>n</sub> = a + (n − 1)b.'
},
{
  q: `Deret geometri <b>1 + 2 + 4 + 8 + ...</b> memiliki jumlah tak hingga S∞ = −1.`,
  ans: false,
  expl: 'SALAH. Rasio r = 2 sehingga |r| > 1; deretnya divergen dan tidak memiliki jumlah tak hingga. Rumus S∞ = a/(1 − r) hanya berlaku untuk |r| < 1.'
},
{
  q: `Untuk suku bunga positif dan periode lebih dari satu tahun, nilai akhir dengan bunga majemuk selalu lebih besar daripada bunga tunggal.`,
  ans: true,
  expl: 'BENAR. Pada bunga majemuk, bunga ikut berbunga pada periode berikutnya, sehingga pertumbuhannya eksponensial dan selalu melampaui pertumbuhan linear bunga tunggal.'
},
{
  q: `Nilai tunai (present value) dari Rp1.000.000 yang akan diterima dua tahun lagi pada suku bunga 10% per tahun adalah kurang dari Rp1.000.000.`,
  ans: true,
  expl: 'BENAR. PV = 1.000.000 / (1,10)² ≈ Rp826.446, yaitu sekitar 82,6% dari nilai nominalnya.'
}
];

/* --------------------------------------------------------- */

const ES = [
{
  q: `<span class="situasi"><b>Situasi.</b> Bu Ratna memiliki dana <b>Rp50.000.000</b> dan mempertimbangkan dua skenario investasi selama <b>5 tahun</b>:
    <ul>
      <li><b>Skenario A</b> — deposito dengan bunga majemuk <b>6% per tahun</b>, tanpa setoran tambahan.</li>
      <li><b>Skenario B</b> — reksa dana dengan proyeksi pertumbuhan <b>4% per tahun</b>, ditambah setoran <b>Rp2.000.000</b> pada setiap akhir tahun.</li>
    </ul></span>
    (a) Hitung nilai akhir masing-masing skenario pada akhir tahun ke-5.<br>
    (b) Hitung persentase keuntungan terhadap <i>total dana yang disetor</i> untuk masing-masing skenario.<br>
    (c) Berikan rekomendasi disertai alasan kuantitatif: skenario mana yang sebaiknya dipilih jika Bu Ratna mengutamakan (i) nilai akhir terbesar, (ii) efisiensi modal tertinggi?`,
  kunci: `
    <b>(a) Nilai akhir setelah 5 tahun</b><br>
    <b>Skenario A:</b> M₅ = 50.000.000 × (1,06)⁵ = 50.000.000 × 1,3382255776 = <b>Rp66.911.279</b> (pembulatan).<br>
    <b>Skenario B:</b> M₅ = 50.000.000 × (1,04)⁵ + 2.000.000 × [(1,04)⁵ − 1] / 0,04<br>
    = 60.832.645,12 + 2.000.000 × 5,41632256<br>
    = 60.832.645,12 + 10.832.645,12 = <b>Rp71.665.290</b>.<br><br>
    <b>(b) Persentase keuntungan</b><br>
    Skenario A: total setoran Rp50.000.000 → laba Rp16.911.279 → <b>≈ 33,82%</b>.<br>
    Skenario B: total setoran Rp50.000.000 + 5 × Rp2.000.000 = Rp60.000.000 → laba Rp11.665.290 → <b>≈ 19,44%</b>.<br><br>
    <b>(c) Rekomendasi</b><br>
    (i) Nilai akhir terbesar → <b>Skenario B</b> (Rp71,67 juta vs Rp66,91 juta; selisih Rp4.754.011).<br>
    (ii) Efisiensi modal tertinggi → <b>Skenario A</b> (33,82% vs 19,44% per rupiah yang disetor).<br>
    <i>Kesimpulan:</i> jika Bu Ratna mengutamakan hasil akhir dan sanggup menyetor Rp2 juta/tahun, pilih <b>B</b>; jika mengutamakan imbal hasil per rupiah modal, pilih <b>A</b>.
  `,
  rubrik: [
    '4 — Ketiga bagian benar; kedua nilai akhir tepat (toleransi pembulatan ±Rp1.000), persentase dihitung terhadap total setoran yang benar, dan rekomendasi eksplisit memisahkan dua kriteria.',
    '3 — Perhitungan benar, tetapi rekomendasi hanya menyebut satu kriteria atau tidak membandingkan keduanya.',
    '2 — Salah satu skenario salah model (misalnya memakai bunga tunggal), atau persentase dihitung terhadap nilai akhir, bukan terhadap setoran.',
    '1 — Hanya menuliskan rumus tanpa perhitungan, atau hanya satu bagian yang benar.',
    '0 — Tidak ada jawaban yang relevan.'
  ],
  catatan: 'Kesalahan umum: (1) memakai bunga tunggal untuk skenario A; (2) menganggap setoran tahunan di skenario B sekadar 5 × Rp2.000.000 tanpa bunga — padahal membentuk deret geometri; (3) membandingkan nilai akhir tanpa menimbang besarnya modal yang disetor.'
},
{
  q: `<span class="situasi"><b>Situasi.</b> CV Kreatif memproduksi <b>x unit</b> kerajinan per bulan. Harga jual per unit (dalam ribu rupiah) mengikuti fungsi permintaan <b>p(x) = 320 − x</b> untuk 0 ≤ x ≤ 320. Biaya total produksi (dalam ribu rupiah) adalah <b>C(x) = 40x + 3.600</b>.</span>
    (a) Susun fungsi pendapatan R(x) = x · p(x) dan fungsi laba L(x) = R(x) − C(x).<br>
    (b) Tentukan jumlah unit yang memaksimalkan laba beserta besar laba maksimum per bulan.<br>
    (c) Manajemen menargetkan laba bulanan minimal <b>Rp10.000.000</b>. Tentukan interval jumlah produksi yang memenuhi target (bulatkan ke satuan).<br>
    (d) Jika mulai bulan berikutnya laba optimal tumbuh <b>5% setiap bulan</b>, tentukan total laba selama 12 bulan pertama.`,
  kunci: `
    <b>(a)</b> R(x) = x(320 − x) = 320x − x².<br>
    L(x) = (320x − x²) − (40x + 3.600) = <b>−x² + 280x − 3.600</b> (dalam ribu rupiah).<br><br>
    <b>(b)</b> Fungsi kuadrat terbuka ke bawah → maksimum di x = −b/(2a) = 280/2 = <b>140 unit</b>.<br>
    L(140) = −(140)² + 280(140) − 3.600 = −19.600 + 39.200 − 3.600 = 16.000 ribu = <b>Rp16.000.000</b>.<br><br>
    <b>(c)</b> −x² + 280x − 3.600 ≥ 10.000 ⟺ x² − 280x + 13.600 ≤ 0.<br>
    Akar-akarnya: x = [280 ± √(78.400 − 54.400)] / 2 = [280 ± √24.000] / 2 = [280 ± 154,919] / 2.<br>
    x₁ ≈ 62,54 dan x₂ ≈ 217,46. Karena x harus bilangan bulat: <b>63 ≤ x ≤ 217 unit</b>.<br><br>
    <b>(d)</b> S₁₂ = 16.000.000 × [(1,05)¹² − 1] / 0,05 = 16.000.000 × 15,91712652 ≈ <b>Rp254.674.024</b>.
  `,
  rubrik: [
    '4 — Keempat bagian benar: fungsi laba tepat, titik optimum dan laba maksimum tepat, interval target benar dengan pembulatan arah yang tepat, serta deret geometri 12 bulan dihitung dengan rumus yang benar.',
    '3 — Tiga bagian benar, atau semua benar tetapi ada kesalahan pembulatan/penulisan satuan (ribu rupiah vs rupiah).',
    '2 — Fungsi laba benar tetapi salah menentukan titik puncak, atau bagian (d) dihitung sebagai 12 × laba (bukan deret geometri).',
    '1 — Hanya menyusun R(x) atau L(x) dengan benar tanpa melanjutkan perhitungan.',
    '0 — Tidak ada jawaban yang relevan.'
  ],
  catatan: 'Kesalahan umum: (1) lupa mengurangkan biaya total sehingga menganggap pendapatan = laba; (2) memakai x = 320 (harga nol) sebagai titik optimum; (3) pada (d) mengalikan laba dengan 12 alih-alih memakai jumlah deret geometri.'
},
{
  q: `<span class="situasi"><b>Situasi.</b> Populasi Kota Nusantara pada awal 2024 tercatat <b>240.000 jiwa</b> dan tumbuh <b>1,5% per tahun</b>, sehingga P(t) = 240.000(1,015)<sup>t</sup> dengan t dalam tahun sejak awal 2024. Luas kota tetap <b>80 km²</b>.</span>
    (a) Nyatakan kepadatan penduduk D (jiwa/km²) sebagai komposisi fungsi D(P(t)), lalu sederhanakan.<br>
    (b) Tentukan waktu (dalam tahun, dua angka desimal) ketika kepadatan penduduk mencapai <b>3.500 jiwa/km²</b>.<br>
    (c) Pemerintah kota menargetkan pembangunan <b>500 unit rumah</b> pada tahun pertama dan meningkat <b>12% setiap tahun</b>. Tentukan total unit rumah yang terbangun dalam 10 tahun pertama (bulatkan ke satuan).`,
  kunci: `
    <b>(a)</b> Kepadatan adalah fungsi dari populasi: D(P) = P / 80.<br>
    Komposisinya: D(P(t)) = 240.000(1,015)<sup>t</sup> / 80 = <b>3.000 · (1,015)<sup>t</sup></b> jiwa/km².<br><br>
    <b>(b)</b> 3.000(1,015)<sup>t</sup> = 3.500 ⟹ (1,015)<sup>t</sup> = 7/6 ≈ 1,1666667.<br>
    t = ln(7/6) / ln(1,015) = 0,15415068 / 0,01488861 ≈ <b>10,35 tahun</b><br>
    (sekitar pertengahan 2034, yaitu ± 10 tahun 4 bulan setelah awal 2024).<br><br>
    <b>(c)</b> S₁₀ = 500 · [(1,12)¹⁰ − 1] / 0,12, dengan (1,12)¹⁰ = 3,1058482.<br>
    S₁₀ = 500 × (2,1058482 / 0,12) = 500 × 17,5487351 ≈ 8.774,37 → <b>≈ 8.774 unit rumah</b>.
  `,
  rubrik: [
    '4 — Komposisi fungsi disusun dan disederhanakan benar; penyelesaian (b) menggunakan logaritma atau invers yang tepat dengan hasil dua desimal; (c) memakai rumus deret geometri dengan pembulatan yang wajar.',
    '3 — Semua langkah benar tetapi ada satu kesalahan kecil (misalnya t dibulatkan ke 10 sehingga hasil (b) kurang presisi).',
    '2 — Bagian (a) benar tetapi (b) diselesaikan secara coba-coba tanpa justifikasi, atau (c) dihitung sebagai 10 × 500.',
    '1 — Hanya menyusun D(P) atau hanya menuliskan rumus deret tanpa menghitung.',
    '0 — Tidak ada jawaban yang relevan.'
  ],
  catatan: 'Kesalahan umum: (1) mengira D(t) = P(t) × 80 (kali, bukan bagi); (2) pada (b) memakai 1,015 × t (pertumbuhan linear) sehingga hasilnya jauh terlalu kecil; (3) pada (c) mengabaikan bahwa 12% adalah pertumbuhan, bukan penambahan tetap.'
},
{
  q: `<span class="situasi"><b>Situasi.</b> Pak Andi meminjam <b>Rp120.000.000</b> di bank dengan suku bunga majemuk <b>9% per tahun</b>. Pinjaman dilunasi dengan anuitas tahunan tetap selama <b>8 tahun</b>.</span>
    (a) Hitung besar anuitas tahunan (bulatkan ke rupiah terdekat).<br>
    (b) Hitung total pembayaran dan total bunga yang dibayarkan selama 8 tahun.<br>
    (c) Setelah 3 kali angsuran, Pak Andi ingin melunasi seluruh sisa pinjaman. Hitung besar pelunasan tersebut.`,
  kunci: `
    <b>(a)</b> A = P · i / [1 − (1 + i)<sup>−n</sup>]<br>
    (1,09)⁸ = 1,9925626 → (1,09)<sup>−8</sup> = 0,5018663 → 1 − 0,5018663 = 0,4981337.<br>
    A = (120.000.000 × 0,09) / 0,4981337 = 10.800.000 / 0,4981337 ≈ <b>Rp21.680.926</b> per tahun.<br><br>
    <b>(b)</b> Total pembayaran = 8 × 21.680.926 = <b>Rp173.447.408</b>.<br>
    Total bunga = 173.447.408 − 120.000.000 = <b>Rp53.447.408</b>.<br><br>
    <b>(c)</b> Sisa pinjaman setelah 3 angsuran = nilai sekarang dari 5 anuitas yang tersisa:<br>
    Sisa = A × [1 − (1,09)<sup>−5</sup>] / 0,09<br>
    (1,09)⁵ = 1,538623955 → (1,09)<sup>−5</sup> = 0,649931386 → 1 − 0,649931386 = 0,350068614.<br>
    Sisa = 21.680.926 × (0,350068614 / 0,09) = 21.680.926 × 3,8896513 ≈ <b>Rp84.331.238</b>.<br>
    <i>Cek silang:</i> 120.000.000(1,09)³ − 21.680.926 × 3,2781 ≈ 155.403.480 − 71.072.242 = Rp84.331.238. ✔
  `,
  rubrik: [
    '4 — Rumus anuitas digunakan dengan benar, ketiga bagian dihitung tepat, dan bagian (c) memakai nilai sekarang dari sisa anuitas (bukan sekadar 5 × anuitas).',
    '3 — Benar semua tetapi ada pembulatan yang membuat selisih cukup besar, atau satuan tidak konsisten.',
    '2 — Anuitas benar, tetapi (b) atau (c) salah konsep (misalnya sisa dihitung sebagai 5 × A = Rp108 juta).',
    '1 — Hanya menuliskan rumus anuitas tanpa perhitungan yang berarti.',
    '0 — Tidak ada jawaban yang relevan.'
  ],
  catatan: 'Kesalahan umum: (1) memakai A = P/n (tanpa bunga); (2) menganggap total bunga = P × i × n; (3) pada (c) menghitung sisa sebagai 5 × anuitas — padahal angsuran masa depan masih mengandung bunga sehingga harus didiskontokan.'
},
{
  q: `<span class="situasi"><b>Situasi.</b> Seorang desainer membuat pola ubin bertingkat. Pola ke-1 memerlukan <b>8 ubin</b>, pola ke-2 memerlukan <b>14 ubin</b>, pola ke-3 memerlukan <b>22 ubin</b>, dan seterusnya, dengan selisih antarpola membentuk barisan aritmatika (6, 8, 10, ...).</span>
    (a) Tentukan rumus banyak ubin pada pola ke-n, U<sub>n</sub>, dan periksa kecocokannya untuk n = 1, 2, 3.<br>
    (b) Tentukan rumus jumlah ubin untuk n pola pertama, S<sub>n</sub>.<br>
    (c) Jika satu ubin berukuran <b>0,04 m²</b> dan tersedia bahan <b>5 m²</b>, tentukan nomor pola terbesar yang masih dapat dibuat seluruhnya beserta sisa bahannya.<br>
    (d) Jika desainer ingin membuat 6 pola sekaligus, berapa tambahan luas bahan minimum yang diperlukan?`,
  kunci: `
    <b>(a)</b> Selisih: 6, 8, 10 → beda keduanya tetap (2), jadi U<sub>n</sub> berbentuk kuadrat.<br>
    Dari U₁ = 8, U₂ = 14, U₃ = 22 diperoleh <b>U<sub>n</sub> = n² + 3n + 4</b>.<br>
    Cek: U₁ = 1 + 3 + 4 = 8 ✔ ; U₂ = 4 + 6 + 4 = 14 ✔ ; U₃ = 9 + 9 + 4 = 22 ✔.<br><br>
    <b>(b)</b> S<sub>n</sub> = Σ(k² + 3k + 4) = n(n+1)(2n+1)/6 + 3n(n+1)/2 + 4n<br>
    = n(2n² + 3n + 1 + 9n + 9 + 24)/6 = n(2n² + 12n + 34)/6<br>
    = <b>n(n² + 6n + 17)/3</b>.<br>
    Cek: S₁ = 24/3 = 8 ✔ ; S₂ = 2(33)/3 = 22 ✔ ; S₃ = 3(44)/3 = 44 (= 8 + 14 + 22) ✔.<br><br>
    <b>(c)</b> Bahan tersedia: 5 / 0,04 = <b>125 ubin</b>.<br>
    S₅ = 5(25 + 30 + 17)/3 = 5(72)/3 = <b>120 ubin</b>.<br>
    S₆ = 6(36 + 36 + 17)/3 = 6(89)/3 = <b>178 ubin</b>.<br>
    Karena 120 ≤ 125 < 178, pola terbesar yang dapat dibuat utuh adalah <b>pola ke-5</b>.<br>
    Sisa bahan = 125 − 120 = 5 ubin = <b>0,2 m²</b>.<br><br>
    <b>(d)</b> Untuk 6 pola diperlukan 178 ubin = 178 × 0,04 = <b>7,12 m²</b>.<br>
    Tambahan minimum = 7,12 − 5 = <b>2,12 m²</b> (setara 53 ubin).
  `,
  rubrik: [
    '4 — Rumus U<sub>n</sub> dan S<sub>n</sub> diturunkan (bukan sekadar ditebak) dan diverifikasi; nomor pola terbesar ditentukan dengan membandingkan S₅ dan S₆ secara eksplisit; sisa bahan dan tambahan bahan dihitung benar.',
    '3 — Semua benar tetapi salah satu verifikasi/satuan terlewat, atau sisa bahan dinyatakan dalam ubin tanpa dikonversi ke m².',
    '2 — U<sub>n</sub> benar tetapi S<sub>n</sub> salah, atau bagian (c) hanya menebak tanpa membandingkan S₅ dan S₆.',
    '1 — Hanya menuliskan U<sub>n</sub> tanpa melanjutkan ke bagian lain.',
    '0 — Tidak ada jawaban yang relevan.'
  ],
  catatan: 'Kesalahan umum: (1) menganggap barisan aritmatika sehingga U<sub>n</sub> = 6n + 2 (gagal untuk n = 3); (2) membagi 125 dengan banyak ubin pola terakhir saja, bukan dengan jumlah kumulatif; (3) lupa mengonversi 5 ubin sisa menjadi m².'
}
];

/* =========================================================
   STATE & RENDER
   ========================================================= */

const S = { pg: 0, bs: 0 };
const esaiSkor = [null, null, null, null, null];
const HURUF = ['A','B','C','D','E'];

function updateScore(){
  let es = 0;
  esaiSkor.forEach(v => { if (typeof v === 'number') es += v; });
  document.getElementById('s-pg').textContent = S.pg;
  document.getElementById('s-bs').textContent = S.bs;
  document.getElementById('s-es').textContent = es;
  document.getElementById('s-tot').textContent = S.pg + S.bs + es;
}

/* ---------- PILIHAN GANDA ---------- */
function renderPG(){
  const host = document.getElementById('pg');
  host.innerHTML = `<div class="section-note"><b>Petunjuk:</b> Pilih satu jawaban, lalu tekan <b>Cek Jawaban</b>. Setiap soal bernilai 1 poin (total 15 poin). Kunci dan pembahasan akan muncul setelah jawaban diperiksa.</div>`;

  PG.forEach((q, i) => {
    const card = document.createElement('article');
    card.className = 'card';
    card.innerHTML = `
      <div class="qhead"><span class="num">${i + 1}</span><div class="qtext">${q.q}</div></div>
      <div class="opts"></div>
      <div class="actions"><button class="btn btn-check" disabled>Cek Jawaban</button></div>
      <div class="feedback hidden"></div>
    `;
    const optsHost = card.querySelector('.opts');
    q.opts.forEach((o, j) => {
      const b = document.createElement('button');
      b.className = 'opt';
      b.type = 'button';
      b.innerHTML = `<span class="tag">${HURUF[j]}</span><span>${o}</span>`;
      b.addEventListener('click', () => {
        if (card.dataset.done) return;
        optsHost.querySelectorAll('.opt').forEach(x => x.classList.remove('sel'));
        b.classList.add('sel');
        card.dataset.pick = j;
        card.querySelector('.btn-check').disabled = false;
      });
      optsHost.appendChild(b);
    });

    card.querySelector('.btn-check').addEventListener('click', () => {
      if (card.dataset.done) return;
      card.dataset.done = '1';
      const pick = Number(card.dataset.pick);
      const benar = pick === q.ans;

      optsHost.querySelectorAll('.opt').forEach((o, j) => {
        o.classList.add('locked');
        o.classList.remove('sel');
        if (j === q.ans) o.classList.add('correct');
        if (j === pick && !benar) o.classList.add('wrong');
      });

      if (benar) S.pg += 1;
      updateScore();

      const btn = card.querySelector('.btn-check');
      btn.disabled = true;
      btn.textContent = 'Sudah diperiksa';

      const fb = card.querySelector('.feedback');
      fb.classList.remove('hidden');
      fb.classList.add(benar ? 'ok' : 'bad');
      fb.innerHTML = `<div class="fbhead">${benar ? '✔ Benar (+1 poin)' : '✘ Belum tepat (0 poin)'}</div>
        <div class="fbtext"><b>Kunci: ${HURUF[q.ans]}.</b> ${q.expl}</div>`;
    });

    host.appendChild(card);
  });
}

/* ---------- BENAR / SALAH ---------- */
function renderBS(){
  const host = document.getElementById('bs');
  host.innerHTML = `<div class="section-note"><b>Petunjuk:</b> Tentukan apakah setiap pernyataan <b>Benar</b> atau <b>Salah</b>. Setelah dijawab, kunci dan alasan singkat akan langsung ditampilkan. Setiap soal bernilai 1 poin (total 10 poin).</div>`;

  BS.forEach((q, i) => {
    const card = document.createElement('article');
    card.className = 'card';
    card.innerHTML = `
      <div class="qhead"><span class="num">${i + 1}</span><div class="qtext">${q.q}</div></div>
      <div class="bsbtns">
        <button type="button" data-v="true">Benar</button>
        <button type="button" data-v="false">Salah</button>
      </div>
      <div class="feedback hidden"></div>
    `;

    const btns = card.querySelectorAll('.bsbtns button');
    btns.forEach(b => {
      b.addEventListener('click', () => {
        if (card.dataset.done) return;
        card.dataset.done = '1';

        const jawab = b.dataset.v === 'true';
        const benar = jawab === q.ans;
        if (benar) S.bs += 1;
        updateScore();

        btns.forEach(x => {
          const val = x.dataset.v === 'true';
          x.disabled = true;
          if (val === q.ans) x.classList.add('reveal-ok');
          else x.classList.add('dim');
        });
        b.classList.remove('reveal-ok', 'dim');
        b.classList.add(benar ? 'pick-ok' : 'pick-bad');

        const fb = card.querySelector('.feedback');
        fb.classList.remove('hidden');
        fb.classList.add(benar ? 'ok' : 'bad');
        fb.innerHTML = `<div class="fbhead">${benar ? '✔ Benar (+1 poin)' : '✘ Belum tepat (0 poin)'} — Kunci: ${q.ans ? 'BENAR' : 'SALAH'}</div>
          <div class="fbtext">${q.expl}</div>`;
      });
    });

    host.appendChild(card);
  });
}

/* ---------- ESAI ---------- */
function renderEsai(){
  const host = document.getElementById('esai');
  host.innerHTML = `<div class="section-note"><b>Petunjuk:</b> Tuliskan langkah penyelesaian secara lengkap. Setelah selesai, tekan <b>Lihat Kunci &amp; Rubrik</b>, bandingkan jawabanmu, lalu isi <b>nilai mandiri</b> (0–4) pada tombol yang tersedia. Total maksimum 20 poin.</div>`;

  ES.forEach((q, i) => {
    const card = document.createElement('article');
    card.className = 'card';
    card.innerHTML = `
      <div class="qhead"><span class="num">${i + 1}</span><div class="qtext">${q.q}</div></div>
      <textarea placeholder="Tuliskan langkah-langkah penyelesaianmu di sini..."></textarea>
      <div class="actions"><button class="btn btn-key" type="button">Lihat Kunci &amp; Rubrik</button></div>
      <div class="keybox hidden">
        <h4>Kunci Jawaban</h4>
        <div class="kunci">${q.kunci}</div>
        <h4>Rubrik Penskoran (0–4)</h4>
        <ul class="rubrik">${q.rubrik.map(r => `<li>${r}</li>`).join('')}</ul>
        <h4>Catatan Kesalahan Umum</h4>
        <div>${q.catatan}</div>
        <div class="selfscore">
          <span>Nilai mandiri:</span>
          ${[0,1,2,3,4].map(n => `<button type="button" data-s="${n}">${n}</button>`).join('')}
        </div>
      </div>
    `;

    card.querySelector('.btn-key').addEventListener('click', () => {
      card.querySelector('.keybox').classList.remove('hidden');
      card.querySelector('.btn-key').textContent = 'Kunci & Rubrik Ditampilkan';
      card.querySelector('.btn-key').disabled = true;
      card.querySelector('.btn-key').style.opacity = '.6';
      card.querySelector('.btn-key').style.cursor = 'default';
    });

    card.querySelectorAll('.selfscore button').forEach(b => {
      b.addEventListener('click', () => {
        card.querySelectorAll('.selfscore button').forEach(x => x.classList.remove('on'));
        b.classList.add('on');
        esaiSkor[i] = Number(b.dataset.s);
        updateScore();
      });
    });

    host.appendChild(card);
  });
}

/* ---------- TAB ---------- */
function initTabs(){
  document.querySelectorAll('.tab').forEach(t => {
    t.addEventListener('click', () => {
      document.querySelectorAll('.tab').forEach(x => x.classList.remove('active'));
      document.querySelectorAll('.panel').forEach(x => x.classList.remove('active'));
      t.classList.add('active');
      document.getElementById(t.dataset.target).classList.add('active');
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  });
}

/* ---------- INIT ---------- */
renderPG();
renderBS();
renderEsai();
initTabs();
updateScore();
</script>
</body>
</html>
