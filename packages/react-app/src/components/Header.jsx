import React from "react";
import { Typography } from "antd";
// import localBackgroundImage from "./img/Count_Zer0_continuity_artificial_intelligence_ca78fd9d-cf3b-44de-8f8b-d35ff0ea8fb0.png";
import localBackgroundImage from "./img/Count_Zer0_continuity_artificial_intelligence_058a6437-bac9-4be8-a9e0-d5985d03a580.png";

const { Title, Text } = Typography;

// displays a page header

export default function Header({ link, title, subTitle, background, ...props }) {
  return (
    <div style={{ display: "flex", justifyContent: "space-between", padding: "1.2rem" }}>
      <div style={{ display: "flex", flexDirection: "column", flex: 1, alignItems: "start" }}>
        <div
          style={{
            backgroundImage: `url(${background})`,
            backgroundPosition: "right",
            backgroundSize: "contain",
            backgroundRepeat: "no-repeat",
            backgroundClip: "padding-box",
            opacity: "1.0",
            // backgroundClip: "content-box",
            // width: "auto",
            width: "110vh",
            height: "30vh",
          }}
        >
          Count zero IntRRupt ....
          <a href={link} target="_blank" rel="noopener noreferrer">
            <Title level={1} style={{ margin: "0 0.5rem 0 0" }}>
              {title}
            </Title>
          </a>
          <Text type="secondary" style={{ textAlign: "right" }}>
            {subTitle}
          </Text>
        </div>
      </div>
      {props.children}
    </div>
  );
}

Header.defaultProps = {
  link: "https://https://github.com/CountZer0/cyberneticOrganism",
  title: "🏗 CyberneticOrganism",
  subTitle: "Archetype DNA for perpetual backup of cyborg traits",
  background: localBackgroundImage,
};
