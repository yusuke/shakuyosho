package ch.deathmar;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.chrono.JapaneseDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

/**
 * Copyright 2013 Yusuke Yamamoto
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * Distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
public class ShakuyoshoGen {
    public static File generateIfNotExist(String from, String to, String 金額) throws ServletException {
        try {
            String path = "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "generated" + File.separator + from + File.separator + to + File.separator;
            new File(path).mkdirs();
            File out = new File(path + 金額 + ".gif");
            if (!out.exists()) {
//                synchronized (ShakuyoshoGen.class) {
                    BufferedImage image = ImageIO.read(ShakuyoshoGen.class.getResourceAsStream("/template.gif"));
                    String 今日 = JapaneseDate.now().format(DateTimeFormatter.ofPattern("y  M  d", Locale.JAPANESE));

                    Graphics2D graphics = image.createGraphics();
                    graphics.setFont(new Font("Arial", Font.BOLD, 70));
                    graphics.setColor(Color.BLACK);
                    graphics.drawString(今日, 120, 150);
                    graphics.drawString(from, 50, 250);
                    graphics.drawString(金額, 100, 450);
                    graphics.drawString(to, 50, 650);
                    ImageIO.write(image, "gif", out);
//                }
            }
            return out;
        } catch (IOException ioe) {
            throw new ServletException((ioe));
        }

    }
}
