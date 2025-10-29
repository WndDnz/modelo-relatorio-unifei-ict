import os

root = r"c:\Projetos\modelo-relatório"
bad = []
for dp, ds, fs in os.walk(root):
    for f in fs:
        p = os.path.join(dp, f)
        try:
            with open(p, "rb") as fh:
                b = fh.read(1024)
        except Exception:
            continue
        if b.find(b"\x00") != -1:
            bad.append(p)
if bad:
    print("\n".join(bad))
else:
    print("No files with NUL bytes detected")
