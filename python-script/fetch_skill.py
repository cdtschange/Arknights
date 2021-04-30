# -*- coding: utf-8 -*-

from __future__ import unicode_literals
import sys
reload(sys) 
sys.setdefaultencoding('utf-8')
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import json
import codecs

url = r'http://prts.wiki/index.php?title=%E7%89%B9%E6%AE%8A:%E6%90%9C%E7%B4%A2&limit=500&offset=0&ns0=1&ns6=1&ns3000=1&search=%E6%8A%80%E8%83%BD'
browser = webdriver.PhantomJS()
browser.get(url)

element = WebDriverWait(browser, 30).until(
        EC.visibility_of_element_located((By.CLASS_NAME,"image"))
)

elements = browser.find_elements_by_class_name('searchResultImage')
skills = {}
i = 0
print('Start....')
for e in elements:
    try:
        text = e.find_element_by_class_name('mw-search-result-data').find_element_by_xpath('preceding-sibling::a').text
        if text == '':
            continue
        

        if (u'文件:技能' in text):
            browser.execute_script("arguments[0].scrollIntoView(true);", e)
            time.sleep(0.2)
            el = e.find_element_by_tag_name('img')
            src = el.get_attribute('src')
            if src.find(u'png/'):
                src = src[:src.find(u'png/') + 3]
            if src.find('thumb'):
                src = src.replace('/thumb', '')
            name = text.replace(u'文件:技能 ', '')
            name = name.replace('.png', '')
            skills[name] = src
            
            i += 1
            print(str(i) + ' ' + name)

    except:
        continue

browser.quit()


fp = codecs.open('./output/operator_skill.json', 'wb', 'utf-8')
fp.write(json.dumps(skills,ensure_ascii=False))
fp.close()
print("Skill写入文件完成...")