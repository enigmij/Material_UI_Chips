/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
@Component
export struct FilterChip {
  @State radius: number = 0
  @State checked: boolean = false
  @State private model: FilterChip.Model = undefined

  aboutToAppear() {
    if (this.model == null || this.model == undefined) return
  }

  private onClick() {
    if (!this.checked) {
      this.checked = true
      animateTo({
        duration: 100,
        onFinish: () => {
          this.radius = 0
          this.model.setColor(this.model.getActiveChipColor())
        }
      }, () => {
        this.radius = 200
      })
      animateTo({ duration: 100 }, () => {
        this.model.setTickSize('18vp')
        this.model.setTickMarginLeft('8vp')
        this.model.setTickMarginTop('7vp')
        this.model.setTickMarginBottom('7vp')
      })
    }
    else {
      animateTo({ duration: 100 }, () => {
        this.model.setTickSize('0vp')
        this.model.setTickMarginLeft('0vp')
        this.model.setTickMarginTop('0vp')
        this.model.setTickMarginBottom('0vp')
      })
      this.model.setColor(this.model.getChipColor())
      this.checked = false
    }
  }

  private destroy() {
    this.model.setChipColor(this.model.getChipColor())
    animateTo({ duration: 100 }, () => {
      this.model.setTextSize('0vp')
      this.model.setTickSize('0vp')
      this.model.setTickMarginLeft('0vp')
      this.model.setTickMarginTop('0vp')
      this.model.setTickMarginBottom('0vp')
      this.model.setTextMarginLeft('0vp')
      this.model.setTextMarginTop('0vp')
      this.model.setTextMarginBottom('0vp')
      this.model.setTextMarginRight('0vp')
      this.model.setCancelChip('0vp')
      this.model.setMargin('0vp')
      this.model.setImageSize('0vp')
      this.model.setMarginImage('0vp')
    })
  }

  build() {
    if (this.model != null && this.model != undefined) {
      Column() {
        Row() {
          Image(this.model.getImage())
            .width(this.model.getImage() == "" || this.model.getImage() == undefined ? '0vp' : this.model.getImageSize())
            .height(this.model.getImage() == "" || this.model.getImage() == undefined ? '0vp' : this.model.getImageSize())
            .margin(this.model.getImage() == "" || this.model.getImage() == undefined ? '0vp' : this.model.getMarginImage())
          Image($r("app.media.Tick"))
            .width(this.model.getTickSize())
            .height(this.model.getTickSize())
            .margin({
              left: this.model.getTickMarginLeft(),
              top: this.model.getTickMarginTop(),
              bottom: this.model.getTickMarginBottom()
            })
          Stack() {
            Circle({ width: '1vp', height: '1vp' })
              .fill(this.model.getActiveChipColor())
              .borderRadius('8vp')
              .scale({ x: this.radius, y: this.radius })
              .clip(true)
            Text(this.model.getText())
              .fontSize(this.model.getTextSize())
              .fontColor(this.checked ? this.model.getActiveTextColor() : this.model.getTextColor())
              .margin({
                left: this.model.getTextMarginLeft(),
                right: this.model.getTextMarginRight(),
                top: this.model.getTextMarginTop(),
                bottom: this.model.getTextMarginBottom()
              })
          }

          Image($r("app.media.cross"))
            .width(this.model.getCancelChip())
            .height(this.model.getCancelChip())
            .margin({ right: this.model.getCancelChip() })
            .onClick(() => this.destroy())
        }
        .borderRadius(this.model.getBorderRadius())
        .backgroundColor(this.checked ? this.model.getColor() : this.model.getChipColor())
        .onClick(() => this.onClick())
        .margin(this.model.getMargin())
        .clip(true)
      }
    }
  }
}

export namespace FilterChip {

  export class Model {
    private text: string | Resource = ""
    private img: string | Resource = ""
    private textSize: string = '20fp'
    private imgSize: string = '16vp'
    private textColor: ResourceColor | string = '#000000'
    private activeTextColor: ResourceColor | string = '#000000'
    private chipColor: ResourceColor | string = '#DCDCDC'
    private activeChipColor: ResourceColor | string = '#800080'
    private color: ResourceColor | string = this.chipColor
    private borderRadius: string = '8vp'
    private tickSize: string = '0vp'
    private tickMarginLeft: string = '0vp'
    private tickMarginTop: string = '0vp'
    private tickMarginBottom: string = '0vp'
    private textMarginLeft: string = '12vp'
    private textMarginRight: string = '12vp'
    private textMarginTop: string = '7vp'
    private textMarginBottom: string = '7vp'
    private cancelChip: string = '16vp'
    private margin: string = '8vp'
    private marginImage: string = '4vp'
    getMarginImage(): string {
      return this.marginImage
    }

    setMarginImage(marginImage: string): Model {
      if (marginImage != null && marginImage != undefined) {
        this.marginImage = marginImage;
      } else {
        this.marginImage = '4vp';
      }
      return this
    }

    getMargin(): string {
      return this.margin
    }

    setMargin(margin: string): Model {
      if (margin != null && margin != undefined) {
        this.margin = margin;
      } else {
        this.margin = '8vp';
      }
      return this
    }

    getCancelChip(): string {
      return this.cancelChip
    }

    setCancelChip(cancelChip: string): Model {
      if (cancelChip != null && cancelChip != undefined) {
        this.cancelChip = cancelChip;
      } else {
        this.cancelChip = '16vp';
      }
      return this
    }

    getTextMarginLeft(): string {
      return this.textMarginLeft
    }

    setTextMarginLeft(textMarginLeft: string): Model {
      if (textMarginLeft != null && textMarginLeft != undefined) {
        this.textMarginLeft = textMarginLeft;
      } else {
        this.textMarginLeft = '0vp';
      }
      return this
    }

    getTextMarginRight(): string {
      return this.textMarginRight
    }

    setTextMarginRight(textMarginRight: string): Model {
      if (textMarginRight != null && textMarginRight != undefined) {
        this.textMarginRight = textMarginRight;
      } else {
        this.textMarginRight = '0vp';
      }
      return this
    }

    getTextMarginBottom(): string {
      return this.textMarginBottom
    }

    setTextMarginBottom(textMarginBottom: string): Model {
      if (textMarginBottom != null && textMarginBottom != undefined) {
        this.textMarginBottom = textMarginBottom;
      } else {
        this.textMarginBottom = '0vp';
      }
      return this
    }

    getTextMarginTop(): string {
      return this.textMarginTop
    }

    setTextMarginTop(textMarginTop: string): Model {
      if (textMarginTop != null && textMarginTop != undefined) {
        this.textMarginTop = textMarginTop;
      } else {
        this.textMarginTop = '0vp';
      }
      return this
    }

    getTickSize(): string {
      return this.tickSize
    }

    setTickSize(tickSize: string): Model {
      if (tickSize != null && tickSize != undefined) {
        this.tickSize = tickSize;
      } else {
        this.tickSize = '0vp';
      }
      return this
    }

    getTickMarginLeft(): string {
      return this.tickMarginLeft
    }

    setTickMarginLeft(tickMarginLeft: string): Model {
      if (tickMarginLeft != null && tickMarginLeft != undefined) {
        this.tickMarginLeft = tickMarginLeft;
      } else {
        this.tickMarginLeft = '0vp';
      }
      return this
    }

    getTickMarginBottom(): string {
      return this.tickMarginBottom
    }

    setTickMarginBottom(tickMarginBottom: string): Model {
      if (tickMarginBottom != null && tickMarginBottom != undefined) {
        this.tickMarginBottom = tickMarginBottom;
      } else {
        this.tickMarginBottom = '0vp';
      }
      return this
    }

    getTickMarginTop(): string {
      return this.tickMarginTop
    }

    setTickMarginTop(tickMarginTop: string): Model {
      if (tickMarginTop != null && tickMarginTop != undefined) {
        this.tickMarginTop = tickMarginTop;
      } else {
        this.tickMarginTop = '0vp';
      }
      return this
    }

    getText(): string | Resource {
      return this.text
    }

    setText(text: string | Resource): Model {
      if (text != null && text != undefined) {
        this.text = text;
      } else {
        this.text = "";
      }
      return this
    }

    getImage(): string | Resource {
      return this.img
    }

    setImage(img: string | Resource): Model {
      if (img != null && img != undefined) {
        this.img = img;
      } else {
        this.img = "";
      }
      return this
    }

    getImageSize(): string {
      return this.imgSize
    }

    setImageSize(imgSize: string): Model {
      if (imgSize != null && imgSize != undefined) {
        this.imgSize = imgSize;
      } else {
        this.imgSize = '16vp';
      }
      return this
    }

    getTextSize(): string {
      return this.textSize
    }

    setTextSize(textSize: string): Model {
      if (textSize != null && textSize != undefined) {
        this.textSize = textSize;
      } else {
        this.textSize = '20fp';
      }
      return this
    }

    getBorderRadius(): string {
      return this.borderRadius
    }

    setBorderRadius(borderRadius: string): Model {
      if (borderRadius != null && borderRadius != undefined) {
        this.borderRadius = borderRadius;
      } else {
        this.borderRadius = '8vp';
      }
      return this
    }

    getTextColor(): ResourceColor | string {
      return this.textColor
    }

    setTextColor(textColor: ResourceColor | string): Model {
      this.textColor = (textColor != null && textColor != undefined) ? textColor : '#000000';
      return this
    }

    getActiveTextColor(): ResourceColor | string {
      return this.activeTextColor
    }

    setActiveTextColor(activeTextColor: ResourceColor | string): Model {
      this.activeTextColor = (activeTextColor != null && activeTextColor != undefined) ? activeTextColor : '#000000';
      return this
    }

    getColor(): ResourceColor | string {
      return this.color
    }

    setColor(color: ResourceColor | string): Model {
      this.color = (color != null && color != undefined) ? color : this.chipColor;
      return this
    }

    getChipColor(): ResourceColor | string {
      return this.chipColor
    }

    setChipColor(chipColor: ResourceColor | string): Model {
      this.chipColor = (chipColor != null && chipColor != undefined) ? chipColor : '#000000';
      return this
    }

    getActiveChipColor(): ResourceColor | string {
      return this.activeChipColor
    }

    setActiveChipColor(activeChipColor: ResourceColor | string): Model {
      this.activeChipColor = (activeChipColor != null && activeChipColor != undefined) ? activeChipColor : '#000000';
      return this
    }

    reset() {
      this.textSize = '20fp'
      this.textMarginTop = '7vp'
      this.textMarginBottom = '7vp'
      this.textMarginRight = '12vp'
      this.textMarginLeft = '12vp'
      this.tickSize = '0vp'
      this.tickMarginLeft = '0vp'
      this.tickMarginBottom = '0vp'
      this.tickMarginTop = '0vp'
      this.margin = '8vp'
      this.imgSize = '16vp'
      this.marginImage = '4vp'
      this.borderRadius = '8vp'
      this.textColor = '#000000'
      this.activeTextColor = '#000000'
      this.chipColor = '#DCDCDC'
      this.activeChipColor = '#800080'
      this.color = this.chipColor
    }
  }
}