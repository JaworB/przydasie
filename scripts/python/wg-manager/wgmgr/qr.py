from __future__ import annotations

import io

import qrcode
import qrcode.image.pil


def ascii_qr(data: str) -> str:
    qr = qrcode.QRCode(border=4)
    qr.add_data(data)
    qr.make(fit=True)
    buf = io.StringIO()
    qr.print_ascii(out=buf)
    return buf.getvalue()


def save_png(data: str, path: str):
    qr = qrcode.QRCode(border=4, image_factory=qrcode.image.pil.PilImage)
    qr.add_data(data)
    qr.make(fit=True)
    qr.make_image().save(path)
