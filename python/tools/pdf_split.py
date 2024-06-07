#! /usr/bin/python3.8

import fitz  # PyMuPDF
import os

# TODO: 弄清楚实现细节

def extract_bookmarks(toc, level=1):
    """提取特定级别的书签"""
    bookmarks = []
    for item in toc:
        if item[0] == level:
            bookmarks.append(item)
    return bookmarks

def find_toc_pages(bookmarks):
    """计算目录的页数"""
    if bookmarks:
        return bookmarks[0][2] - 1  # 第一个 Level 1 章节之前的页数
    else:
        return 0

def split_pdf_by_bookmarks(input_pdf, output_dir, level=1):
    """按指定级别的书签拆分PDF并保留目录信息，并将目录页面另存为目录.pdf"""
    # 打开PDF文件
    document = fitz.open(input_pdf)
    
    # 获取目录信息
    toc = document.get_toc()
    
    # 提取特定级别的书签
    bookmarks = extract_bookmarks(toc, level)
    
    # 确定目录的页数
    toc_pages = find_toc_pages(bookmarks)
    
    # 确保输出目录存在
    os.makedirs(output_dir, exist_ok=True)
    
    # 提取并保存目录页面
    toc_pdf = fitz.open()
    toc_pdf.insert_pdf(document, from_page=0, to_page=toc_pages - 1)
    toc_pdf_path = os.path.join(output_dir, "目录.pdf")
    toc_pdf.save(toc_pdf_path)
    toc_pdf.close()
    
    # 遍历书签并拆分PDF
    for i, (bookmark_level, title, page) in enumerate(bookmarks):
        # 确定拆分的起始和结束页
        start_page = page - 1  # 页码从0开始
        end_page = bookmarks[i + 1][2] - 1 if i + 1 < len(bookmarks) else document.page_count
        
        # 创建新PDF
        new_pdf = fitz.open()
        new_pdf.insert_pdf(document, from_page=start_page, to_page=end_page - 1)
        
        # 获取新的目录信息
        new_toc = [item for item in toc if start_page <= item[2] - 1 < end_page]
        new_toc = [[level, title, p - start_page + 1] for level, title, p in new_toc]
        
        # 添加目录信息
        new_pdf.set_toc(new_toc)
        
        # 保存新PDF
        sanitized_title = title.replace("/", "-")  # 替换标题中的非法字符
        output_pdf_path = os.path.join(output_dir, f"{sanitized_title}.pdf")
        new_pdf.save(output_pdf_path)
        new_pdf.close()
        
    document.close()

# 使用示例
input_pdf = "KVM虚拟化技术-实战与原理解析.pdf"
output_dir = "output"
split_pdf_by_bookmarks(input_pdf, output_dir, level=1)
